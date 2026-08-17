-- =====================================================================
-- FITUR STOCK OPNAME + LOG PENYESUAIAN  (FASE 2)
-- =====================================================================
--
-- Menambah dua tabel:
--   stock_opname          : header sesi opname
--   stock_opname_details  : baris per produk -> INI LOG AUDIT-nya
--
-- Lima hal yang dicatat pada setiap penyesuaian:
--   1. Jam                    -> adjusted_time (+ adjusted_at)
--   2. Tanggal                -> adjusted_date
--   3. User yang mengubah     -> adjusted_by (join ke tabel users)
--   4. Sebelum & sesudah      -> qty_system -> qty_physical
--                                selisihnya di qty_difference
--   5. Alasan perubahan       -> reason_code + reason_note
--
-- PRINSIP: opname TIDAK menimpa stok. Yang disimpan adalah SELISIH,
-- sehingga data pembelian & penjualan tidak pernah disentuh dan angka
-- keuangan (hutang distributor, omzet, laba) tidak ikut berubah.
--
-- Rumus stok menjadi:
--   Stok = Pembelian - Penjualan + Sum(selisih opname yang sudah diposting)
--
-- Dijalankan pada `apotik_alang_new`
-- (lihat application/config/database.php).
-- Aman dijalankan berulang kali.
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1) HEADER SESI OPNAME
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `stock_opname` (
  `id`            INT(11)       NOT NULL AUTO_INCREMENT,
  `opname_no`     VARCHAR(30)   NOT NULL COMMENT 'Nomor opname, mis. OPN-20260817-0001',
  `opname_date`   DATE          NOT NULL COMMENT 'Tanggal pelaksanaan opname',
  `opname_time`   TIME          NOT NULL COMMENT 'Jam pelaksanaan opname',
  `note`          TEXT          NULL     COMMENT 'Catatan umum sesi opname',
  `status`        TINYINT(1)    NOT NULL DEFAULT 0 COMMENT '0=Draft, 1=Posted',
  `total_item`    INT(11)       NOT NULL DEFAULT 0 COMMENT 'Jumlah produk yang punya selisih',
  `total_selisih` DECIMAL(12,2) NOT NULL DEFAULT 0.00 COMMENT 'Jumlah seluruh selisih kuantitas',
  `created_by`    VARCHAR(15)   NOT NULL COMMENT 'users.user_id pembuat draft',
  `created_at`    DATETIME      NOT NULL COMMENT 'Waktu draft dibuat',
  `posted_by`     VARCHAR(15)   NULL     COMMENT 'users.user_id yang melakukan posting',
  `posted_at`     DATETIME      NULL     COMMENT 'Waktu posting, saat stok resmi berubah',
  PRIMARY KEY (`id`),
  UNIQUE KEY `opname_no` (`opname_no`),
  KEY `opname_date` (`opname_date`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ---------------------------------------------------------------------
-- 2) DETAIL PER PRODUK  --  TABEL LOG AUDIT
-- ---------------------------------------------------------------------
--   Kolom log diisi PER BARIS, bukan diambil dari header, karena dalam
--   satu sesi opname item bisa dihitung petugas berbeda pada jam berbeda.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `stock_opname_details` (
  `id`             INT(11)       NOT NULL AUTO_INCREMENT,
  `opname_id`      INT(11)       NOT NULL COMMENT 'FK ke stock_opname.id',
  `opname_no`      VARCHAR(30)   NOT NULL COMMENT 'Denormalisasi, mempermudah query log',
  `product_id`     VARCHAR(100)  NOT NULL COMMENT 'FK ke product_information.product_id',
  `batch_id`       VARCHAR(30)   NULL     COMMENT 'Disiapkan untuk opname per batch, belum dipakai',

  -- (4) PERUBAHAN: SEBELUM BERAPA, SESUDAH BERAPA
  `qty_system`     DECIMAL(12,2) NOT NULL DEFAULT 0.00 COMMENT 'SEBELUM: stok menurut sistem saat opname',
  `qty_physical`   DECIMAL(12,2) NOT NULL DEFAULT 0.00 COMMENT 'SESUDAH: stok fisik hasil hitung',
  `qty_difference` DECIMAL(12,2) NOT NULL DEFAULT 0.00 COMMENT 'fisik - sistem (+ lebih, - kurang)',

  -- (5) ALASAN PERUBAHAN
  `reason_code`    VARCHAR(30)   NOT NULL DEFAULT 'other' COMMENT 'Kategori alasan',
  `reason_note`    TEXT          NULL     COMMENT 'Penjelasan bebas',

  -- (1)(2)(3) JAM, TANGGAL, USER
  `adjusted_date`  DATE          NOT NULL COMMENT 'TANGGAL penyesuaian',
  `adjusted_time`  TIME          NOT NULL COMMENT 'JAM penyesuaian',
  `adjusted_at`    DATETIME      NOT NULL COMMENT 'Gabungan tanggal+jam, untuk urutan kronologis',
  `adjusted_by`    VARCHAR(15)   NOT NULL COMMENT 'USER pelaku, users.user_id',

  `status`         TINYINT(1)    NOT NULL DEFAULT 0 COMMENT '0=Draft, 1=Posted, mengikuti header',
  PRIMARY KEY (`id`),
  KEY `opname_id` (`opname_id`),
  KEY `product_id` (`product_id`),
  KEY `adjusted_by` (`adjusted_by`),
  KEY `adjusted_date` (`adjusted_date`),
  KEY `status_product` (`status`, `product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ---------------------------------------------------------------------
-- 3) AKTIFKAN KOMPONEN OPNAME PADA VIEW STOK
-- ---------------------------------------------------------------------
--   Pada Fase 1 kolom qty_adjustment sengaja dipatok 0 supaya struktur
--   kolom view tidak berubah. Di sini bagian LEFT JOIN opname diaktifkan.
--   Struktur kolom TETAP SAMA, jadi seluruh pemanggil view (18 lokasi di
--   Reports.php & Searchs.php) tidak perlu disentuh sama sekali.
--
--   Perhatikan `WHERE status = 1`: hanya opname yang SUDAH DIPOSTING yang
--   memengaruhi stok. Draft tidak berpengaruh -- inilah yang membuat
--   sistem draft aman.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW `view_stock_current` AS
SELECT
    p.product_id                                                        AS product_id,
    IFNULL(beli.qty, 0)                                                 AS qty_purchase,
    IFNULL(jual.qty, 0)                                                 AS qty_sales,
    IFNULL(opn.qty, 0)                                                  AS qty_adjustment,
    (IFNULL(beli.qty, 0) - IFNULL(jual.qty, 0) + IFNULL(opn.qty, 0))    AS stock
FROM product_information p
LEFT JOIN (
    SELECT product_id, SUM(quantity) AS qty
    FROM product_purchase_details
    GROUP BY product_id
) beli ON beli.product_id = p.product_id
LEFT JOIN (
    SELECT product_id, SUM(quantity) AS qty
    FROM invoice_details
    GROUP BY product_id
) jual ON jual.product_id = p.product_id
LEFT JOIN (
    SELECT product_id, SUM(qty_difference) AS qty
    FROM stock_opname_details
    WHERE status = 1
    GROUP BY product_id
) opn ON opn.product_id = p.product_id;


-- ---------------------------------------------------------------------
-- 4) LABEL BAHASA
-- ---------------------------------------------------------------------
--   Hanya frasa yang belum ada. Frasa umum seperti quantity, unit, date,
--   total, status, action, search, reset, print sudah tersedia.
--   Catatan: frasa `note` sudah dipakai modul retur dengan arti
--   "Alasan Pengembalian", jadi di sini memakai kunci sendiri.
-- ---------------------------------------------------------------------
INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'stock_opname' AS p, 'Stock Opname' AS e, 'Stock Opname' AS b) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='stock_opname');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'add_stock_opname','Add Stock Opname','Tambah Stock Opname') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='add_stock_opname');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'opname_list','Stock Opname List','Daftar Stock Opname') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='opname_list');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'opname_log','Stock Opname Log','Log Stock Opname') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='opname_log');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'opname_no','Opname No','No. Opname') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='opname_no');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'opname_date','Opname Date','Tanggal Opname') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='opname_date');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'opname_note','Opname Note','Catatan Opname') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='opname_note');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'qty_system','System Qty','Stok Sistem') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='qty_system');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'qty_physical','Physical Qty','Stok Fisik') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='qty_physical');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'qty_difference','Difference','Selisih') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='qty_difference');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'opname_reason','Reason','Alasan') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='opname_reason');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'reason_note','Reason Note','Keterangan Alasan') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='reason_note');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'adjusted_by','Adjusted By','Disesuaikan Oleh') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='adjusted_by');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'adjusted_time','Time','Jam') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='adjusted_time');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'post_opname','Post Opname','Posting Opname') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='post_opname');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'save_draft','Save Draft','Simpan Draft') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='save_draft');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'opname_draft' AS p,'Draft' AS e,'Draft' AS b) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='opname_draft');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'opname_posted','Posted','Sudah Diposting') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='opname_posted');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'total_item','Total Item','Jumlah Item') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='total_item');

-- kategori alasan
INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'reason_damaged','Damaged','Barang Rusak') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='reason_damaged');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'reason_expired','Expired','Kadaluarsa') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='reason_expired');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'reason_lost','Lost / Stolen','Hilang / Kecurian') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='reason_lost');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'reason_miscount','Previous Miscount','Salah Hitung Sebelumnya') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='reason_miscount');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'reason_input_error','Transaction Input Error','Salah Input Transaksi') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='reason_input_error');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'reason_found','Item Found','Barang Ditemukan Kembali') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='reason_found');

INSERT INTO `language` (`phrase`, `english`, `bahasa`)
SELECT * FROM (SELECT 'reason_other','Other','Lainnya') AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='reason_other');


-- ---------------------------------------------------------------------
-- 5) MENU (SUB MODUL) -- modul Stock sudah ada dengan id 6
-- ---------------------------------------------------------------------
INSERT INTO `sub_module` (`mid`,`name`,`description`,`image`,`directory`,`status`)
SELECT * FROM (SELECT 6 AS m,'Add Stock Opname' AS n,'' AS d,'' AS i,'add_stock_opname' AS dir,1 AS s) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `sub_module` WHERE `directory`='add_stock_opname');

INSERT INTO `sub_module` (`mid`,`name`,`description`,`image`,`directory`,`status`)
SELECT * FROM (SELECT 6 AS m,'Stock Opname List' AS n,'' AS d,'' AS i,'opname_list' AS dir,1 AS s) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `sub_module` WHERE `directory`='opname_list');

INSERT INTO `sub_module` (`mid`,`name`,`description`,`image`,`directory`,`status`)
SELECT * FROM (SELECT 6 AS m,'Stock Opname Log' AS n,'' AS d,'' AS i,'opname_log' AS dir,1 AS s) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `sub_module` WHERE `directory`='opname_log');


-- ---------------------------------------------------------------------
-- 6) HAK AKSES: berikan penuh ke seluruh role yang ada
-- ---------------------------------------------------------------------
--   Tanpa baris ini menunya tidak akan muncul untuk siapa pun.
--   Bisa disesuaikan lewat menu Role Permission setelah migrasi.
-- ---------------------------------------------------------------------
INSERT INTO `role_permission` (`fk_module_id`,`role_id`,`create`,`read`,`update`,`delete`)
SELECT sm.id, r.id, 1, 1, 1, 1
FROM `sub_module` sm
CROSS JOIN `sec_role` r
WHERE sm.directory IN ('add_stock_opname','opname_list','opname_log')
  AND NOT EXISTS (
      SELECT 1 FROM `role_permission` rp
      WHERE rp.fk_module_id = sm.id AND rp.role_id = r.id
  );
