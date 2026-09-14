-- =====================================================================
-- LOG PERUBAHAN HARGA JUAL BARANG
-- =====================================================================
--
-- Mencatat setiap kali HARGA JUAL (product_information.price) sebuah
-- barang diubah lewat form edit produk. Yang dicatat:
--   1. Jam perubahan          -> changed_time (+ changed_at)
--   2. Tanggal perubahan       -> changed_date
--   3. User yang mengubah      -> changed_by (users.user_id)
--   4. Sebelum & sesudah        -> old_price -> new_price
--   5. Alasan perubahan        -> reason (teks bebas, wajib diisi)
--
-- CATATAN COLLATION
--   Kolom product_id & changed_by dibuat mengikuti collation kolom
--   pasangannya (product_information.product_id, users.user_id) DINAMIS
--   sesuai server. Ini mencegah error "Illegal mix of collations" saat
--   JOIN di hosting -- masalah yang sempat terjadi pada tabel stock opname.
--
-- Dijalankan pada database aktif. Aman dijalankan berulang kali.
-- =====================================================================

CREATE TABLE IF NOT EXISTS `price_change_log` (
  `id`           INT(11)       NOT NULL AUTO_INCREMENT,
  `product_id`   VARCHAR(100)  NOT NULL COMMENT 'FK ke product_information.product_id',
  `old_price`    DECIMAL(20,2) NOT NULL DEFAULT 0.00 COMMENT 'SEBELUM: harga jual lama',
  `new_price`    DECIMAL(20,2) NOT NULL DEFAULT 0.00 COMMENT 'SESUDAH: harga jual baru',
  `reason`       TEXT          NULL     COMMENT 'Alasan perubahan (teks bebas)',
  `changed_date` DATE          NOT NULL COMMENT 'TANGGAL perubahan',
  `changed_time` TIME          NOT NULL COMMENT 'JAM perubahan',
  `changed_at`   DATETIME      NOT NULL COMMENT 'Gabungan, untuk urutan kronologis',
  `changed_by`   VARCHAR(15)   NOT NULL COMMENT 'USER pelaku, users.user_id',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `changed_by` (`changed_by`),
  KEY `changed_date` (`changed_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Samakan collation kolom JOIN dengan tabel pasangannya (dinamis per server)
SET @db := DATABASE();

SET @coll_prod := (SELECT COLLATION_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA=@db AND TABLE_NAME='product_information' AND COLUMN_NAME='product_id');
SET @cs_prod := (SELECT CHARACTER_SET_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA=@db AND TABLE_NAME='product_information' AND COLUMN_NAME='product_id');

SET @coll_user := (SELECT COLLATION_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA=@db AND TABLE_NAME='users' AND COLUMN_NAME='user_id');
SET @cs_user := (SELECT CHARACTER_SET_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA=@db AND TABLE_NAME='users' AND COLUMN_NAME='user_id');

SET @sql := CONCAT('ALTER TABLE `price_change_log` MODIFY `product_id` VARCHAR(100) ',
    'CHARACTER SET ', @cs_prod, ' COLLATE ', @coll_prod, ' NOT NULL');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

SET @sql := CONCAT('ALTER TABLE `price_change_log` MODIFY `changed_by` VARCHAR(15) ',
    'CHARACTER SET ', @cs_user, ' COLLATE ', @coll_user, ' NOT NULL');
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;


-- ---------------------------------------------------------------------
-- Label bahasa (hanya yang belum ada)
-- ---------------------------------------------------------------------
INSERT INTO `language` (`phrase`,`english`,`bahasa`)
SELECT * FROM (SELECT 'price_change_log' AS p,'Price Change Log' AS e,'Log Perubahan Harga' AS b) AS t
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='price_change_log');

INSERT INTO `language` (`phrase`,`english`,`bahasa`)
SELECT * FROM (SELECT 'old_price','Old Price','Harga Lama') AS t
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='old_price');

INSERT INTO `language` (`phrase`,`english`,`bahasa`)
SELECT * FROM (SELECT 'new_price','New Price','Harga Baru') AS t
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='new_price');

INSERT INTO `language` (`phrase`,`english`,`bahasa`)
SELECT * FROM (SELECT 'price_change_reason','Reason','Alasan Perubahan') AS t
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='price_change_reason');

INSERT INTO `language` (`phrase`,`english`,`bahasa`)
SELECT * FROM (SELECT 'changed_by','Changed By','Diubah Oleh') AS t
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='changed_by');

INSERT INTO `language` (`phrase`,`english`,`bahasa`)
SELECT * FROM (SELECT 'change_time','Time','Jam') AS t
WHERE NOT EXISTS (SELECT 1 FROM `language` WHERE `phrase`='change_time');


-- ---------------------------------------------------------------------
-- Menu (sub_module) di modul Master Data + hak akses seluruh role
--   Modul induk untuk produk memakai mid yang sama dengan 'manage_product'.
-- ---------------------------------------------------------------------
SET @mid := (SELECT mid FROM sub_module WHERE directory='manage_medicine' LIMIT 1);

INSERT INTO `sub_module` (`mid`,`name`,`description`,`image`,`directory`,`status`)
SELECT * FROM (SELECT @mid AS m,'Price Change Log' AS n,'' AS d,'' AS i,'price_change_log' AS dir,1 AS s) AS t
WHERE @mid IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `sub_module` WHERE `directory`='price_change_log');

INSERT INTO `role_permission` (`fk_module_id`,`role_id`,`create`,`read`,`update`,`delete`)
SELECT sm.id, r.id, 1, 1, 1, 1
FROM `sub_module` sm
CROSS JOIN `sec_role` r
WHERE sm.directory = 'price_change_log'
  AND NOT EXISTS (
      SELECT 1 FROM `role_permission` rp
      WHERE rp.fk_module_id = sm.id AND rp.role_id = r.id
  );
