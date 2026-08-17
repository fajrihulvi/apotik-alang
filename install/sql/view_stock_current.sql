-- =====================================================================
-- VIEW TERPUSAT PERHITUNGAN STOK  (FASE 1 - SENTRALISASI RUMUS)
-- =====================================================================
--
-- LATAR BELAKANG
--   Stok di sistem ini tidak disimpan sebagai kolom, melainkan selalu
--   dihitung: pembelian dikurangi penjualan. Sebelum file ini dibuat,
--   rumus tersebut ditulis ulang di 18 lokasi dengan 3 gaya berbeda:
--
--     Gaya A : (select ifnull(sum(quantity),0) ...) subquery berpasangan
--              -> 12x di Reports.php, 1x di Searchs.php
--     Gaya B : (select sum(quantity) ...) TANPA ifnull
--              -> 3x di Reports.php (baris 11, 23, 575)
--     Gaya C : pengurangan dilakukan di dalam loop PHP, bukan di SQL
--              -> 2x di Reports.php (baris 203, 1401)
--
--   Akibatnya setiap perubahan pada perhitungan stok harus disalin ke 18
--   tempat. Bila satu terlewat, dua laporan bisa menampilkan angka stok
--   berbeda untuk produk yang sama.
--
-- TUJUAN VIEW INI
--   Menjadi SATU-SATUNYA sumber kebenaran stok. Seluruh laporan cukup
--   melakukan JOIN ke view ini.
--
-- DUA MASALAH LAMA YANG SEKALIAN DIPERBAIKI
--   1. Gaya B tanpa ifnull menghasilkan NULL (bukan 0) untuk produk yang
--      belum pernah dibeli/dijual. Saat file ini dibuat, 826 dari 1.209
--      produk menghasilkan NULL. View ini selalu mengembalikan 0.
--   2. Gaya C menjalankan 2 query per produk di dalam loop PHP. Untuk
--      1.209 produk itu ~2.418 query per halaman. View ini dipanggil
--      sekali lewat JOIN.
--
-- DATABASE
--   Dijalankan pada `apotik_alang_new` (lihat application/config/database.php).
--
-- CATATAN PENTING
--   Kolom qty_adjustment sengaja sudah disiapkan sekarang dan bernilai 0,
--   supaya struktur kolom view TIDAK berubah lagi saat fitur Stock Opname
--   (Fase 2) dipasang. Nanti di Fase 2 hanya bagian LEFT JOIN opname yang
--   diaktifkan; semua pemanggil view tidak perlu disentuh ulang.
--
--   Aman dijalankan berulang kali (CREATE OR REPLACE).
-- =====================================================================

CREATE OR REPLACE VIEW `view_stock_current` AS
SELECT
    p.product_id                                    AS product_id,
    IFNULL(beli.qty, 0)                             AS qty_purchase,
    IFNULL(jual.qty, 0)                             AS qty_sales,
    CAST(0 AS DECIMAL(20,2))                        AS qty_adjustment,
    (IFNULL(beli.qty, 0) - IFNULL(jual.qty, 0))     AS stock
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
) jual ON jual.product_id = p.product_id;


-- =====================================================================
-- VIEW STOK PER BATCH
-- =====================================================================
--   Dipakai laporan stok batch-wise (gaya C, Reports.php baris 1401)
--   yang sebelumnya menghitung stok per batch lewat query di dalam loop.
--
--   Perhatikan: penjualan digabungkan berdasarkan product_id + batch_id,
--   sama persis dengan perilaku query lama yang digantikan.
-- =====================================================================

CREATE OR REPLACE VIEW `view_stock_batch_current` AS
SELECT
    beli.product_id                                 AS product_id,
    beli.batch_id                                   AS batch_id,
    beli.qty                                        AS qty_purchase,
    IFNULL(jual.qty, 0)                             AS qty_sales,
    (beli.qty - IFNULL(jual.qty, 0))                AS stock
FROM (
    SELECT product_id, batch_id, SUM(quantity) AS qty
    FROM product_purchase_details
    GROUP BY product_id, batch_id
) beli
LEFT JOIN (
    SELECT product_id, batch_id, SUM(quantity) AS qty
    FROM invoice_details
    GROUP BY product_id, batch_id
) jual ON jual.product_id = beli.product_id
      AND jual.batch_id   = beli.batch_id;
