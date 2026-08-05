-- =====================================================================
-- CEK KESEHATAN STOK
-- =====================================================================
--
-- Skrip pemeriksaan, HANYA MEMBACA. Tidak mengubah data apa pun,
-- jadi aman dijalankan kapan saja di produksi.
--
-- Laporan stok menghitung: stok = total pembelian - total penjualan.
-- Saldo awal dari sistem lama direpresentasikan sebagai baris pembelian
-- ber-batch 'OPN...'. Skrip ini mencari kondisi yang melanggar pola itu.
--
-- Jalankan rutin (mis. sebulan sekali) atau setiap sesudah impor data.
--
-- CARA BACA: idealnya C1, C2, C4, C5 kosong. C3 boleh berisi.
--
-- ---------------------------------------------------------------------
-- PENTING - SESUDAH MENJALANKAN rename_kolom_stok.sql
-- ---------------------------------------------------------------------
-- Skrip ini merujuk kolom `p.stok`. Bila Anda sudah menjalankan
-- rename_kolom_stok.sql, kolom itu bernama `stok_migrasi_arsip` dan
-- skrip ini akan gagal dengan pesan:
--     ERROR 1054: Unknown column 'p.stok' in 'field list'
--
-- Perbaikannya: cari-ganti seluruh isi file ini,
--     dari : p.stok
--     jadi : p.stok_migrasi_arsip
-- (ada 11 kemunculan). Sesudah itu skrip berjalan normal kembali.
-- =====================================================================

-- ---------------------------------------------------------------------
-- C1. STOK NEGATIF  [KRITIS]
-- Stok tercatat minus - mustahil secara fisik. Biasanya karena barang
-- terjual tapi saldo awalnya belum pernah dibuatkan baris OPN.
-- HARAPAN: kosong.
-- ---------------------------------------------------------------------
SELECT 'C1. STOK NEGATIF (kritis)' AS pemeriksaan;

SELECT p.product_id, p.product_name, p.stok AS kolom_stok_arsip,
       (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d WHERE d.product_id=p.product_id) AS beli,
       (SELECT IFNULL(SUM(quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id) AS jual,
       (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d WHERE d.product_id=p.product_id)
     - (SELECT IFNULL(SUM(quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id) AS stok_laporan
FROM product_information p
HAVING stok_laporan < 0
ORDER BY stok_laporan ASC;

-- ---------------------------------------------------------------------
-- C2. SALDO AWAL DOBEL  [KRITIS]
-- Produk dengan lebih dari satu baris OPN. Menandakan skrip migrasi
-- pernah jalan dua kali. Efeknya stok tampil LEBIH BESAR dari kenyataan
-- - lebih berbahaya daripada minus karena tidak terlihat salah.
-- HARAPAN: kosong.
-- ---------------------------------------------------------------------
SELECT 'C2. SALDO AWAL DOBEL (kritis)' AS pemeriksaan;

SELECT d.product_id, p.product_name,
       COUNT(*) AS jml_baris_opn,
       SUM(d.quantity) AS total_qty_opn,
       p.stok AS kolom_stok_arsip
FROM product_purchase_details d
LEFT JOIN product_information p ON p.product_id = d.product_id
WHERE d.batch_id LIKE 'OPN%'
GROUP BY d.product_id, p.product_name, p.stok
HAVING jml_baris_opn > 1
ORDER BY jml_baris_opn DESC;

-- ---------------------------------------------------------------------
-- C3. SALDO AWAL BELUM DIBUAT  [INFO]
-- Punya nilai stok arsip tapi belum ada baris pembelian sama sekali,
-- DAN belum pernah terjual. Stok tampil 0 di laporan.
-- Tidak berbahaya (tidak menimbulkan stok hantu), tapi barang ini
-- tidak bisa dijual lewat POS sampai saldonya dibuat.
-- Perlu stock opname untuk memastikan barangnya memang ada.
-- HARAPAN: boleh berisi. Turunkan lewat opname bertahap.
-- ---------------------------------------------------------------------
SELECT 'C3. BELUM ADA SALDO AWAL - perlu opname (info)' AS pemeriksaan;

SELECT COUNT(*) AS jumlah_produk, IFNULL(SUM(p.stok),0) AS total_qty_tertahan
FROM product_information p
WHERE p.stok <> 0
  AND NOT EXISTS (SELECT 1 FROM product_purchase_details d WHERE d.product_id=p.product_id)
  AND (SELECT IFNULL(SUM(i.quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id) <= 0;

-- ---------------------------------------------------------------------
-- C4. SALDO AWAL TIDAK COCOK  [PERLU CEK]
-- Total baris OPN tidak sama dengan kolom stok arsip.
-- Produk yang punya pembelian baru setelah migrasi SUDAH DIKECUALIKAN
-- di sini, karena selisih pada kasus itu memang wajar.
-- HARAPAN: kosong.
-- ---------------------------------------------------------------------
SELECT 'C4. SALDO AWAL TIDAK COCOK (perlu cek)' AS pemeriksaan;

SELECT p.product_id, p.product_name, p.stok AS kolom_stok_arsip,
       (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d
         WHERE d.product_id=p.product_id AND d.batch_id LIKE 'OPN%') AS saldo_awal_opn,
       (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d
         WHERE d.product_id=p.product_id AND d.batch_id NOT LIKE 'OPN%') AS pembelian_baru
FROM product_information p
WHERE p.stok <> 0
  AND EXISTS (SELECT 1 FROM product_purchase_details d WHERE d.product_id=p.product_id)
  AND (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d
        WHERE d.product_id=p.product_id AND d.batch_id LIKE 'OPN%') <> p.stok
ORDER BY p.product_name;

-- ---------------------------------------------------------------------
-- C5. BARIS PEMBELIAN YATIM  [PERLU CEK]
-- Detail pembelian yang induknya (product_purchase) tidak ada.
-- HARAPAN: kosong.
-- ---------------------------------------------------------------------
SELECT 'C5. DETAIL PEMBELIAN YATIM (perlu cek)' AS pemeriksaan;

SELECT d.purchase_id, COUNT(*) AS jml_baris
FROM product_purchase_details d
WHERE NOT EXISTS (SELECT 1 FROM product_purchase p WHERE p.purchase_id = d.purchase_id)
GROUP BY d.purchase_id;

-- ---------------------------------------------------------------------
-- RINGKASAN
-- ---------------------------------------------------------------------
SELECT 'RINGKASAN' AS pemeriksaan;

SELECT
  (SELECT COUNT(*) FROM (
     SELECT (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d WHERE d.product_id=p.product_id)
          - (SELECT IFNULL(SUM(quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id) AS s
     FROM product_information p) t WHERE s < 0)                      AS c1_stok_negatif,
  (SELECT COUNT(*) FROM (
     SELECT product_id FROM product_purchase_details WHERE batch_id LIKE 'OPN%'
     GROUP BY product_id HAVING COUNT(*) > 1) t2)                    AS c2_saldo_dobel,
  (SELECT COUNT(*) FROM product_information p
     WHERE p.stok <> 0
       AND NOT EXISTS (SELECT 1 FROM product_purchase_details d WHERE d.product_id=p.product_id)
       AND (SELECT IFNULL(SUM(i.quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id) <= 0)
                                                                     AS c3_perlu_opname,
  (SELECT COUNT(*) FROM product_information p
     WHERE p.stok <> 0
       AND EXISTS (SELECT 1 FROM product_purchase_details d WHERE d.product_id=p.product_id)
       AND (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d
             WHERE d.product_id=p.product_id AND d.batch_id LIKE 'OPN%') <> p.stok)
                                                                     AS c4_saldo_tak_cocok;
