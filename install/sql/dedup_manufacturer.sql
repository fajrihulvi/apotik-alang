-- =============================================================
-- Merapikan duplikat `manufacturer_information` setelah migrasi
-- data supplier dari alangfarma.sql.
--
-- JALANKAN SETELAH: install/sql/migrasi_supplier_ke_manufacturer.sql
--
-- Masalah:
--   Tabel `manufacturer_information` sudah berisi beberapa distributor
--   yang diinput manual. Migrasi supplier memakai `id_supplier` sebagai
--   `manufacturer_id`, sehingga ID-nya tidak bentrok TAPI menghasilkan
--   dua baris untuk perusahaan yang sama.
--
--   ID lama (dipertahankan)          ID baru (digabung & dihapus)
--   -------------------------------  -----------------------------------
--   1  Kimia Farma                    80  PT KIMIA FARMA
--   3  PT Anugrah Pharmindo Lestari   26  PT. ANUGERAH PHARMINDO LESTARI
--
--   Baris LAMA yang dipertahankan, karena sudah dirujuk transaksi
--   (product_information / product_purchase / acc_coa). Data alamat &
--   telepon dari baris baru disalin ke baris lama bila baris lama kosong,
--   lalu semua referensi dialihkan ke ID lama dan baris baru dihapus.
--
-- CATATAN: `manufacturer_id` bertipe beda-beda antar tabel
--   (bigint di product_information, varchar di product_purchase &
--   product_return) sehingga perbandingan dilakukan sebagai string.
--
-- Tabel yang punya kolom manufacturer_id: acc_coa, product_information,
-- product_purchase, product_return.
--
-- CADANGKAN DATABASE SEBELUM MENJALANKAN:
--   mysqldump -u root apotik_alang > backup_sebelum_dedup.sql
-- =============================================================

SET NAMES utf8mb4;

-- -------------------------------------------------------------
-- Daftar pasangan duplikat: id_lama (dipertahankan) <- id_baru (dihapus)
-- Tambahkan baris di sini bila menemukan duplikat lain.
-- -------------------------------------------------------------
DROP TEMPORARY TABLE IF EXISTS `tmp_dedup_map`;
CREATE TEMPORARY TABLE `tmp_dedup_map` (
  `id_keep` BIGINT NOT NULL,
  `id_drop` BIGINT NOT NULL,
  PRIMARY KEY (`id_drop`)
) ENGINE=MEMORY;

INSERT INTO `tmp_dedup_map` (`id_keep`, `id_drop`) VALUES
  (1, 80),   -- Kimia Farma                  <- PT KIMIA FARMA
  (3, 26);   -- PT Anugrah Pharmindo Lestari <- PT. ANUGERAH PHARMINDO LESTARI

-- Amankan: buang pasangan yang salah satu barisnya tidak ada,
-- supaya script tetap aman dijalankan ulang (idempoten).
DELETE m FROM `tmp_dedup_map` m
LEFT JOIN `manufacturer_information` k ON k.`manufacturer_id` = m.`id_keep`
LEFT JOIN `manufacturer_information` d ON d.`manufacturer_id` = m.`id_drop`
WHERE k.`manufacturer_id` IS NULL OR d.`manufacturer_id` IS NULL;


-- -------------------------------------------------------------
-- 1) Lengkapi data baris LAMA dari baris BARU (hanya isi yang kosong)
--    Baris lama sering minim data karena diinput terburu-buru.
-- -------------------------------------------------------------
UPDATE `manufacturer_information` k
JOIN `tmp_dedup_map` m ON m.`id_keep` = k.`manufacturer_id`
JOIN `manufacturer_information` d ON d.`manufacturer_id` = m.`id_drop`
SET
  k.`address` = IF(TRIM(COALESCE(k.`address`,'')) = '', d.`address`, k.`address`),
  k.`mobile`  = IF(TRIM(COALESCE(k.`mobile`,''))  = '', d.`mobile`,  k.`mobile`),
  k.`contact` = IF(TRIM(COALESCE(k.`contact`,'')) = '', d.`contact`, k.`contact`),
  k.`phone`   = IF(TRIM(COALESCE(k.`phone`,''))   = '', d.`phone`,   k.`phone`),
  k.`details` = IF(TRIM(COALESCE(k.`details`,'')) = '', d.`details`, k.`details`),
  -- is_pbf: gabungkan secara OR, cukup salah satu bertanda PBF.
  k.`is_pbf`  = GREATEST(COALESCE(k.`is_pbf`,0), COALESCE(d.`is_pbf`,0));


-- -------------------------------------------------------------
-- 2) Alihkan seluruh referensi dari id_drop -> id_keep
-- -------------------------------------------------------------

-- product_information.manufacturer_id : bigint(20)
UPDATE `product_information` p
JOIN `tmp_dedup_map` m ON p.`manufacturer_id` = m.`id_drop`
SET p.`manufacturer_id` = m.`id_keep`;

-- acc_coa.manufacturer_id : int(11)
UPDATE `acc_coa` a
JOIN `tmp_dedup_map` m ON a.`manufacturer_id` = m.`id_drop`
SET a.`manufacturer_id` = m.`id_keep`;

-- product_purchase.manufacturer_id : varchar(100) -> bandingkan sebagai string
UPDATE `product_purchase` p
JOIN `tmp_dedup_map` m ON p.`manufacturer_id` = CAST(m.`id_drop` AS CHAR)
SET p.`manufacturer_id` = CAST(m.`id_keep` AS CHAR);

-- product_return.manufacturer_id : varchar(30) -> bandingkan sebagai string
UPDATE `product_return` p
JOIN `tmp_dedup_map` m ON p.`manufacturer_id` = CAST(m.`id_drop` AS CHAR)
SET p.`manufacturer_id` = CAST(m.`id_keep` AS CHAR);


-- -------------------------------------------------------------
-- 3) Hapus baris duplikat yang sudah tidak dirujuk
-- -------------------------------------------------------------
DELETE d FROM `manufacturer_information` d
JOIN `tmp_dedup_map` m ON d.`manufacturer_id` = m.`id_drop`;

DROP TEMPORARY TABLE IF EXISTS `tmp_dedup_map`;


-- =============================================================
-- VERIFIKASI (jalankan manual setelah script di atas)
-- =============================================================
-- a) Pastikan tidak ada referensi menggantung ke manufacturer yang hilang:
--
--   SELECT 'product_information' AS tabel, p.manufacturer_id
--     FROM product_information p
--     LEFT JOIN manufacturer_information m
--            ON m.manufacturer_id = p.manufacturer_id
--    WHERE p.manufacturer_id IS NOT NULL AND p.manufacturer_id <> 0
--      AND m.manufacturer_id IS NULL
--   UNION ALL
--   SELECT 'product_purchase', p.manufacturer_id
--     FROM product_purchase p
--     LEFT JOIN manufacturer_information m
--            ON CAST(m.manufacturer_id AS CHAR) = p.manufacturer_id
--    WHERE p.manufacturer_id IS NOT NULL AND p.manufacturer_id <> ''
--      AND m.manufacturer_id IS NULL
--   UNION ALL
--   SELECT 'product_return', p.manufacturer_id
--     FROM product_return p
--     LEFT JOIN manufacturer_information m
--            ON CAST(m.manufacturer_id AS CHAR) = p.manufacturer_id
--    WHERE p.manufacturer_id IS NOT NULL AND p.manufacturer_id <> ''
--      AND m.manufacturer_id IS NULL;
--
--   -> Harus mengembalikan 0 baris.
--
-- b) Cari sisa duplikat nama (abaikan PT/CV, tanda baca, dan huruf besar):
--
--   SELECT LOWER(REPLACE(REPLACE(REPLACE(REPLACE(manufacturer_name,
--            'PT.',''),'PT',''),'CV.',''),'.','')) AS nama_norm,
--          COUNT(*) AS jml,
--          GROUP_CONCAT(manufacturer_id ORDER BY manufacturer_id) AS ids
--     FROM manufacturer_information
--    GROUP BY nama_norm
--   HAVING jml > 1;
--
--   -> Periksa hasilnya, lalu tambahkan ke tmp_dedup_map bila memang duplikat.
-- =============================================================
