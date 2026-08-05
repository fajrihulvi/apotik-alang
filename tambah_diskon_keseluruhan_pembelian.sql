-- =====================================================================
-- TAMBAH DISKON KESELURUHAN PADA PEMBELIAN
-- =====================================================================
--
-- Menambah 3 kolom pada tabel product_purchase:
--
--   overall_discount_type  : 'percent' atau 'fixed'
--   overall_discount_input : angka yang diketik user (mis. 10 untuk 10%,
--                            atau 100000 untuk nominal)
--   overall_discount_amount: hasil rupiah diskon keseluruhan
--
-- CATATAN PENTING soal kolom yang sudah ada:
--   grand_total_amount -> mulai sekarang menyimpan jumlah SESUDAH diskon
--                         keseluruhan (yang benar-benar dibayar).
--   total_discount     -> tetap berisi total diskon PER BARANG saja.
--                         Diskon keseluruhan ada di kolom baru, sengaja
--                         dipisah supaya data lama tidak berubah artinya.
--
-- Aman dijalankan: kolom baru punya DEFAULT, jadi seluruh baris pembelian
-- lama otomatis bernilai 0 (tanpa diskon keseluruhan) dan tetap valid.
--
-- Jalankan SEBELUM memakai fitur diskon keseluruhan.
-- =====================================================================

ALTER TABLE product_purchase
  ADD COLUMN overall_discount_type VARCHAR(10) NOT NULL DEFAULT 'percent'
    COMMENT 'Jenis diskon keseluruhan: percent | fixed'
    AFTER total_discount,
  ADD COLUMN overall_discount_input DECIMAL(12,2) NOT NULL DEFAULT 0.00
    COMMENT 'Nilai diskon keseluruhan yang diketik user (persen atau nominal)'
    AFTER overall_discount_type,
  ADD COLUMN overall_discount_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00
    COMMENT 'Hasil rupiah diskon keseluruhan'
    AFTER overall_discount_input;

-- ---------------------------------------------------------------------
-- Label bahasa untuk kolom baru di form.
-- Dipakai oleh display('overall_discount'). Tanpa baris ini, label di
-- form akan tampil kosong.
-- Memakai INSERT ... SELECT ... WHERE NOT EXISTS supaya aman bila
-- dijalankan ulang (tidak menimbulkan baris ganda).
-- ---------------------------------------------------------------------
INSERT INTO language (phrase, english, bahasa)
SELECT 'overall_discount', 'Overall Discount', 'Diskon Keseluruhan'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM language WHERE phrase = 'overall_discount');

-- Verifikasi kolom
SELECT column_name, column_type, column_default, column_comment
FROM information_schema.columns
WHERE table_schema = DATABASE()
  AND table_name = 'product_purchase'
  AND column_name IN ('overall_discount_type','overall_discount_input','overall_discount_amount');

-- Verifikasi label
SELECT phrase, english, bahasa FROM language WHERE phrase = 'overall_discount';
