-- =====================================================================
-- TAMBAH PPN (PAJAK PERTAMBAHAN NILAI) PADA PEMBELIAN
-- =====================================================================
--
-- Menambah 3 kolom pada tabel product_purchase:
--
--   ppn_type   : 'percent' atau 'fixed'
--   ppn_input  : angka yang diketik user (mis. 11 untuk 11%,
--                atau 50000 untuk nominal)
--   ppn_amount : hasil rupiah PPN
--
-- URUTAN PERHITUNGAN
--   Sub Total          = jumlah seluruh barang (sesudah diskon per barang)
--   Diskon Keseluruhan = potongan atas Sub Total
--   Dasar Pengenaan    = Sub Total - Diskon Keseluruhan
--   PPN                = dihitung dari Dasar Pengenaan, lalu DITAMBAHKAN
--   Grand Total        = Dasar Pengenaan + PPN
--
--   PPN dihitung SESUDAH diskon karena secara perpajakan dasar pengenaan
--   pajak adalah nilai transaksi bersih, yaitu sesudah potongan harga.
--
-- CATATAN
--   grand_total_amount tetap menyimpan jumlah akhir yang dibayar,
--   kini sudah termasuk PPN.
--
-- Aman dijalankan: kolom baru punya DEFAULT, jadi seluruh nota pembelian
-- lama otomatis bernilai 0 (tanpa PPN) dan tetap valid.
--
-- Jalankan SESUDAH tambah_diskon_keseluruhan_pembelian.sql.
-- =====================================================================

ALTER TABLE product_purchase
  ADD COLUMN ppn_type VARCHAR(10) NOT NULL DEFAULT 'percent'
    COMMENT 'Jenis PPN: percent | fixed'
    AFTER overall_discount_amount,
  ADD COLUMN ppn_input DECIMAL(12,2) NOT NULL DEFAULT 0.00
    COMMENT 'Nilai PPN yang diketik user (persen atau nominal)'
    AFTER ppn_type,
  ADD COLUMN ppn_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00
    COMMENT 'Hasil rupiah PPN'
    AFTER ppn_input;

-- ---------------------------------------------------------------------
-- Label bahasa. Dipakai oleh display('ppn') dan display('dpp').
-- Aman dijalankan ulang (tidak menimbulkan baris ganda).
-- ---------------------------------------------------------------------
INSERT INTO language (phrase, english, bahasa)
SELECT 'ppn', 'PPN', 'PPN'
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM language WHERE phrase = 'ppn');

-- Verifikasi kolom
SELECT column_name, column_type, column_default, column_comment
FROM information_schema.columns
WHERE table_schema = DATABASE()
  AND table_name = 'product_purchase'
  AND column_name IN ('ppn_type','ppn_input','ppn_amount');

-- Verifikasi label
SELECT phrase, english, bahasa FROM language WHERE phrase = 'ppn';
