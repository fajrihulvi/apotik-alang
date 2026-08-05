-- =====================================================================
-- PENSIUNKAN KOLOM product_information.stok
-- =====================================================================
--
-- LATAR BELAKANG
--   Kolom `stok` berisi saldo hasil migrasi sistem lama. Nilainya STATIS:
--   tidak pernah berkurang saat penjualan dan tidak pernah bertambah saat
--   pembelian. Stok yang sebenarnya dihitung dari tabel transaksi
--   (total pembelian - total penjualan), dan saldo awal sudah
--   direpresentasikan sebagai baris pembelian ber-batch 'OPN...'.
--
--   Sudah diverifikasi: TIDAK ADA satu baris kode pun di aplikasi yang
--   membaca kolom ini (dicek di seluruh application/, views, dan js).
--
-- KENAPA DI-RENAME, BUKAN DI-DROP
--   Isinya mirip-tapi-tidak-sama dengan stok terkini. Dibiarkan bernama
--   `stok`, cepat atau lambat ada yang mengira itu stok sekarang lalu
--   memakainya - persis jenis kekeliruan yang menimbulkan bug laporan ini.
--   Datanya tetap disimpan sebagai jejak audit migrasi, hanya namanya
--   dibuat jelas bahwa itu arsip.
--
-- PRASYARAT
--   Jalankan SESUDAH migrasi_saldo_awal_16_produk.sql, dan sesudah
--   cek_kesehatan_stok.sql menunjukkan C1 = 0.
--   Selama masih ada produk di C3 (perlu opname), kolom ini masih
--   dipakai sebagai rujukan opname - itu sebabnya JANGAN di-DROP dulu.
--
-- CARA PAKAI
--   1. BACKUP DATABASE DULU.
--   2. Jalankan di phpMyAdmin tab SQL.
--   3. Verifikasi aplikasi tetap berjalan normal (laporan stok, POS,
--      kelola produk, pembelian).
-- =====================================================================

ALTER TABLE product_information
  CHANGE COLUMN `stok` `stok_migrasi_arsip` DOUBLE NOT NULL DEFAULT 0
  COMMENT 'ARSIP saldo migrasi sistem lama. BUKAN stok terkini dan tidak dipakai aplikasi. Stok sebenarnya = SUM(product_purchase_details.quantity) - SUM(invoice_details.quantity). Jangan dipakai untuk perhitungan.';

-- Verifikasi: kolom baru harus muncul lengkap dengan komentarnya.
SELECT column_name, column_type, column_default, column_comment
FROM information_schema.columns
WHERE table_schema = DATABASE()
  AND table_name = 'product_information'
  AND column_name = 'stok_migrasi_arsip';

-- Verifikasi: nilai lama harus tetap utuh.
-- Mintz permen mint harus tetap menunjukkan 47.
SELECT product_id, product_name, stok_migrasi_arsip
FROM product_information
WHERE product_id = '8979384389482';
