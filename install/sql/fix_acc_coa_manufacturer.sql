-- =============================================================
-- Perbaikan: buat akun COA (acc_coa) untuk manufacturer yang belum punya.
--
-- MASALAH YANG DIPERBAIKI
--   Saat menyimpan pembelian, muncul:
--     Notice: Trying to get property 'HeadCode' of non-object
--             (models/Purchases.php baris 258 & 313)
--     Error 1048: Column 'COAID' cannot be null
--
--   Penyebabnya: Purchases.php baris 196 mencari akun COA distributor:
--     SELECT * FROM acc_coa WHERE manufacturer_id = <id>
--   Bila baris itu tidak ada, ->row() mengembalikan NULL, sehingga
--   $manuf_coa->HeadCode ikut NULL dan INSERT ke `acc_transaction`
--   ditolak karena kolom COAID NOT NULL.
--
--   Normalnya baris acc_coa dibuat otomatis oleh Cmanufacturer.php saat
--   distributor ditambahkan lewat form. Distributor yang masuk lewat
--   impor massal (migrasi_supplier_ke_manufacturer.sql) melewati proses
--   itu, jadi akun COA-nya tidak pernah dibuat.
--
-- YANG DILAKUKAN SCRIPT INI
--   Membuat satu baris `acc_coa` untuk setiap manufacturer yang belum
--   punya, mengikuti pola yang dipakai Cmanufacturer.php:
--     HeadCode   : lanjut dari MAX(HeadCode) pada HeadLevel=3 LIKE '50200%'
--     HeadName   : '<nama manufacturer>-<manufacturer_id>'
--     PHeadName  : 'Account Payable'   (hutang usaha)
--     HeadLevel  : 3, HeadType 'L' (Liability), IsTransaction 1
--
--   Aman dijalankan berulang: manufacturer yang sudah punya COA dilewati.
--
-- CADANGKAN DULU:
--   mysqldump -u root apotik_alang > backup_sebelum_fix_coa.sql
-- =============================================================

SET NAMES utf8mb4;

-- -------------------------------------------------------------
-- 1) Nomor HeadCode terakhir yang dipakai untuk akun distributor.
--    Pola sama dengan Manufacturers::headcode().
--    Bila belum ada sama sekali, mulai dari 502000000 supaya
--    penomoran pertama menjadi 502000001.
-- -------------------------------------------------------------
SET @last := (
  SELECT COALESCE(MAX(CAST(`HeadCode` AS UNSIGNED)), 502000000)
    FROM `acc_coa`
   WHERE `HeadLevel` = '3'
     AND `HeadCode` LIKE '50200%'
);

SET @rn := 0;

-- -------------------------------------------------------------
-- 2) Buat akun COA untuk manufacturer yang belum punya.
-- -------------------------------------------------------------
-- Catatan: `UpdateBy` dan `UpdateDate` NOT NULL tanpa default. Baris COA
-- yang dibuat aplikasi mengisinya dengan string kosong dan '0000-00-00',
-- jadi diikuti agar konsisten. (Zero-date perlu sql_mode tanpa
-- NO_ZERO_DATE; nilai ini sama dengan data yang sudah ada.)
INSERT INTO `acc_coa`
  (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`,
   `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `manufacturer_id`,
   `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`,
   `UpdateBy`, `UpdateDate`)
SELECT
  -- CAST ke UNSIGNED penting: tanpa itu @rn menghasilkan DECIMAL dan
  -- HeadCode (varchar) terisi '502000004.0000...' sehingga tidak cocok
  -- dengan pola penomoran aplikasi.
  CAST(@last + (@rn := @rn + 1) AS UNSIGNED)     AS `HeadCode`,
  CONCAT(m.`manufacturer_name`, '-', m.`manufacturer_id`) AS `HeadName`,
  'Account Payable'                              AS `PHeadName`,
  '3'                                            AS `HeadLevel`,
  '1'                                            AS `IsActive`,
  '1'                                            AS `IsTransaction`,
  '0'                                            AS `IsGL`,
  'L'                                            AS `HeadType`,
  '0'                                            AS `IsBudget`,
  m.`manufacturer_id`                            AS `manufacturer_id`,
  '0'                                            AS `IsDepreciation`,
  '0'                                            AS `DepreciationRate`,
  'system-import'                                AS `CreateBy`,
  NOW()                                          AS `CreateDate`,
  ''                                             AS `UpdateBy`,
  '0000-00-00 00:00:00'                          AS `UpdateDate`
FROM `manufacturer_information` m
WHERE NOT EXISTS (
        SELECT 1 FROM `acc_coa` c
         WHERE c.`manufacturer_id` = m.`manufacturer_id`
      )
ORDER BY m.`manufacturer_id`;


-- =============================================================
-- VERIFIKASI (jalankan manual setelah script di atas)
-- =============================================================
-- a) Semua manufacturer harus sudah punya akun COA -> hasil 0 baris:
--
--   SELECT m.manufacturer_id, m.manufacturer_name
--     FROM manufacturer_information m
--     LEFT JOIN acc_coa c ON c.manufacturer_id = m.manufacturer_id
--    WHERE c.manufacturer_id IS NULL;
--
-- b) Pastikan tidak ada HeadCode ganda -> hasil 0 baris:
--
--   SELECT HeadCode, COUNT(*) FROM acc_coa
--    GROUP BY HeadCode HAVING COUNT(*) > 1;
--
-- c) Lihat hasilnya:
--
--   SELECT c.HeadCode, c.HeadName, c.manufacturer_id
--     FROM acc_coa c WHERE c.manufacturer_id IS NOT NULL
--    ORDER BY c.HeadCode;
-- =============================================================
