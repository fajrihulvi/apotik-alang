-- =====================================================================
-- MIGRASI SALDO AWAL — 16 PRODUK YANG STOK LAPORANNYA NEGATIF
-- =====================================================================
--
-- MASALAH
--   Laporan stok menghitung stok sebagai (total pembelian - total penjualan).
--   16 produk ini punya nilai di kolom product_information.stok (hasil migrasi
--   sistem lama) tetapi TIDAK punya baris pembelian sama sekali, sehingga
--   suku pertama = 0 dan hasilnya negatif sebesar jumlah yang sudah terjual.
--   Contoh: Mintz permen mint -> stok 47, terjual 12, laporan menampilkan -12.
--
-- SOLUSI
--   Membuat baris "pembelian saldo awal" (batch OPN...) untuk 16 produk ini,
--   mengikuti konvensi yang SUDAH dipakai 1091 baris OPN lain di database ini.
--   Setelah ini: 47 + 0 - 12 = 35. Tidak ada kode aplikasi yang diubah.
--
-- CAKUPAN
--   HANYA 16 produk yang: stok<>0 DAN belum ada pembelian DAN sudah ada
--   penjualan. Riwayat penjualan itu bukti barangnya memang ada di rak.
--   88 produk lain yang stok<>0 tanpa pembelian DAN tanpa penjualan
--   SENGAJA TIDAK disentuh — perlu stock opname dulu supaya tidak
--   memunculkan stok hantu.
--
-- SIFAT SKRIP
--   Idempoten. Aman dijalankan ulang: kondisi NOT EXISTS memastikan produk
--   yang sudah punya baris pembelian tidak akan diproses lagi, jadi tidak
--   akan terjadi saldo dobel.
--
-- CARA PAKAI
--   1. BACKUP DATABASE DULU. Wajib, jangan dilewati.
--   2. Jalankan seluruh file ini di phpMyAdmin (tab SQL) database produksi.
--   3. Periksa hasil verifikasi di bagian akhir.
--
-- Dibuat: 2026-08-05
-- =====================================================================

START TRANSACTION;

-- ---------------------------------------------------------------------
-- LANGKAH 0 — Kumpulkan 16 produk sasaran ke tabel sementara.
-- Definisinya berbasis kondisi data, bukan daftar id yang di-hardcode,
-- sehingga skrip tetap benar bila dijalankan ulang.
-- ---------------------------------------------------------------------
DROP TEMPORARY TABLE IF EXISTS tmp_saldo_awal;
CREATE TEMPORARY TABLE tmp_saldo_awal (
  product_id      VARCHAR(100) NOT NULL PRIMARY KEY,
  product_name    VARCHAR(255) NOT NULL,
  qty             DECIMAL(12,2) NOT NULL,
  rate            DECIMAL(10,2) NOT NULL,
  manufacturer_id VARCHAR(100) NOT NULL,
  urut            INT NOT NULL
);

SET @row := 0;

INSERT INTO tmp_saldo_awal (product_id, product_name, qty, rate, manufacturer_id, urut)
SELECT t.product_id, t.product_name, t.stok, t.rate, t.manufacturer_id, (@row := @row + 1)
FROM (
  SELECT p.product_id,
         p.product_name,
         p.stok,
         IFNULL(p.manufacturer_price, 0) AS rate,
         p.manufacturer_id
  FROM product_information p
  WHERE p.stok <> 0
    -- belum punya baris pembelian sama sekali (ini yang bikin negatif)
    AND NOT EXISTS (
      SELECT 1 FROM product_purchase_details d WHERE d.product_id = p.product_id
    )
    -- sudah pernah terjual -> bukti barang nyata ada.
    -- Memakai SUM, bukan EXISTS: ada produk yang punya baris penjualan +1
    -- dan retur -1 sehingga totalnya nol. Produk seperti itu tidak membuat
    -- stok negatif, jadi tidak termasuk sasaran perbaikan ini.
    AND (
      SELECT IFNULL(SUM(i.quantity), 0) FROM invoice_details i
      WHERE i.product_id = p.product_id
    ) > 0
  ORDER BY p.product_name
) t;

-- ---------------------------------------------------------------------
-- LANGKAH 1 — Buat satu induk pembelian (product_purchase).
-- Konvensi lama menampung banyak detail di bawah satu induk
-- (mis. PUR00002 menampung 624 baris), jadi cukup satu induk di sini.
-- ---------------------------------------------------------------------
SET @purchase_id := CONCAT('OPN-FIX-', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'));
SET @chalan_no   := CONCAT('OPEN-FIX-', DATE_FORMAT(NOW(), '%Y%m%d'));
SET @tanggal     := DATE_FORMAT(NOW(), '%Y-%m-%d');

-- manufacturer_id diambil dari produk pertama; seluruh 16 produk bernilai 48.
SET @manufacturer_id := (SELECT manufacturer_id FROM tmp_saldo_awal ORDER BY urut LIMIT 1);
SET @grand_total     := (SELECT IFNULL(SUM(qty * rate), 0) FROM tmp_saldo_awal);

INSERT INTO product_purchase
  (chalan_no, manufacturer_id, grand_total_amount, total_discount,
   purchase_date, purchase_details, status, purchase_id, bank_id, payment_type)
SELECT @chalan_no, @manufacturer_id, @grand_total, 0,
       @tanggal, 'Saldo awal stok - perbaikan 16 produk stok negatif', 1,
       @purchase_id, '', 1
FROM DUAL
WHERE (SELECT COUNT(*) FROM tmp_saldo_awal) > 0;

-- ---------------------------------------------------------------------
-- LANGKAH 2 — Buat baris detail pembelian, satu per produk.
-- batch_id melanjutkan penomoran OPN yang sudah ada (OPN001196 -> OPN001197...).
-- expeire_date 2028-01-01 dan status 0 mengikuti baris OPN lama.
-- ---------------------------------------------------------------------
-- CAST(... AS UNSIGNED) dibungkus FLOOR + CAST ulang karena sebagian batch_id
-- lama tidak murni angka, sehingga MAX bisa menghasilkan nilai desimal dan
-- membuat batch baru jadi 'OPN1197.0'. Dipaksa integer di sini.
SET @opn_mulai := (
  SELECT CAST(IFNULL(FLOOR(MAX(CAST(SUBSTRING(batch_id, 4) AS UNSIGNED))), 0) AS UNSIGNED)
  FROM product_purchase_details WHERE batch_id LIKE 'OPN%'
);

INSERT INTO product_purchase_details
  (purchase_detail_id, purchase_id, product_id, quantity, rate,
   total_amount, discount, batch_id, expeire_date, status)
SELECT
  CONCAT('OPNFIX', LPAD(t.urut, 4, '0'), DATE_FORMAT(NOW(), '%H%i%s')),
  @purchase_id,
  t.product_id,
  t.qty,
  t.rate,
  (t.qty * t.rate),
  0,
  CONCAT('OPN', LPAD(CAST(@opn_mulai + t.urut AS UNSIGNED), 6, '0')),
  '2028-01-01',
  0
FROM tmp_saldo_awal t
-- pengaman ganda: lewati bila entah bagaimana sudah ada pembelian
WHERE NOT EXISTS (
  SELECT 1 FROM product_purchase_details d WHERE d.product_id = t.product_id
);

COMMIT;

-- =====================================================================
-- VERIFIKASI — jalankan dan periksa hasilnya
-- =====================================================================

-- V1. Mintz permen mint. Kolom stok_laporan HARUS bernilai 35.
SELECT p.product_name,
       p.stok AS kolom_stok_lama,
       (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d WHERE d.product_id=p.product_id) AS beli,
       (SELECT IFNULL(SUM(quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id) AS jual,
       (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d WHERE d.product_id=p.product_id)
     - (SELECT IFNULL(SUM(quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id) AS stok_laporan
FROM product_information p
WHERE p.product_id = '8979384389482';

-- V2. Tidak boleh ada lagi produk berstok negatif. HARUS kosong (0 baris).
SELECT p.product_id, p.product_name,
       (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d WHERE d.product_id=p.product_id)
     - (SELECT IFNULL(SUM(quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id) AS stok_laporan
FROM product_information p
HAVING stok_laporan < 0
ORDER BY stok_laporan ASC;

-- V3. Ke-16 produk: stok_laporan harus sama dengan (kolom stok - jual),
--     dan kolom selisih harus 0 untuk semuanya.
SELECT p.product_name,
       p.stok AS kolom_stok,
       (SELECT IFNULL(SUM(quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id) AS jual,
       (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d WHERE d.product_id=p.product_id)
     - (SELECT IFNULL(SUM(quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id) AS stok_laporan,
       (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d WHERE d.product_id=p.product_id)
     - (SELECT IFNULL(SUM(quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id)
     - (p.stok - (SELECT IFNULL(SUM(quantity),0) FROM invoice_details i WHERE i.product_id=p.product_id)) AS selisih
FROM product_information p
WHERE EXISTS (SELECT 1 FROM product_purchase_details d
              WHERE d.product_id=p.product_id AND d.purchase_detail_id LIKE 'OPNFIX%')
ORDER BY p.product_name;

-- V4. Tidak ada produk dengan baris OPN dobel. HARUS kosong (0 baris).
SELECT product_id, COUNT(*) AS jml_baris_opn, SUM(quantity) AS total_opn
FROM product_purchase_details
WHERE batch_id LIKE 'OPN%'
GROUP BY product_id
HAVING jml_baris_opn > 1;

-- V5. Rekap. tanpa_beli harus berkurang dari 104 menjadi 88
--     (16 sudah diperbaiki, 88 sisanya sengaja dibiarkan untuk stock opname).
SELECT
  SUM(CASE WHEN beli=0 AND stok<>0 THEN 1 ELSE 0 END) AS tanpa_beli,
  SUM(CASE WHEN beli>0 AND stok<>0 AND ABS(beli-stok)<0.001 THEN 1 ELSE 0 END) AS sama,
  SUM(CASE WHEN beli>0 AND stok<>0 AND ABS(beli-stok)>=0.001 THEN 1 ELSE 0 END) AS beda
FROM (
  SELECT p.stok,
         (SELECT IFNULL(SUM(quantity),0) FROM product_purchase_details d WHERE d.product_id=p.product_id) AS beli
  FROM product_information p WHERE p.stok <> 0
) t;
