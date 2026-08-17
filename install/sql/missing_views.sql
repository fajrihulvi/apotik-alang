-- =====================================================================
-- MEMBUAT DUA VIEW YANG DIRUJUK KODE TAPI TIDAK PERNAH ADA  (FASE 5)
-- =====================================================================
--
-- Sejak awal kode merujuk dua view yang tidak pernah dibuat di database
-- apotik_alang_new, sehingga query-nya diam-diam gagal (mengembalikan
-- kosong) tanpa pesan error yang jelas:
--
--   view_product_report      -> Products.php baris 398 & 420
--                               dipakai halaman "Kartu Stok / pergerakan
--                               stok per produk"
--                               (Cproduct/product_sales_manufacturer_rate)
--
--   view_k_stock_batch_qty   -> Reports.php baris 1238 & 1430
--                               HANYA dipakai stock_report_batch_bydate()
--                               dan stock_report_batch_count() yang KEDUANYA
--                               tidak dipanggil dari mana pun (dead code).
--                               View tetap dibuat agar konsisten & tidak
--                               menjadi jebakan bila fungsi itu dihidupkan.
--
-- Dijalankan pada `apotik_alang_new`.
-- Aman dijalankan berulang kali (CREATE OR REPLACE).
-- =====================================================================


-- ---------------------------------------------------------------------
-- 1) view_product_report  --  buku pergerakan stok per produk
-- ---------------------------------------------------------------------
--   Menggabungkan pembelian dan penjualan menjadi satu daftar mutasi.
--
--   Kolom yang dibutuhkan pemanggil (Products.php):
--     product_id, date, quantity, rate, account
--
--   Kolom `account` menandai jenis baris, sesuai pembacaan di
--   Lproduct.php::product_sales_manufacturer_rate():
--     'a'  = pembelian (barang MASUK)
--     lain = penjualan (barang KELUAR)
--   Di sana quantity pembelian dijadikan "in" dan quantity penjualan
--   dijadikan "out", jadi keduanya disimpan sebagai angka apa adanya
--   dari tabel sumber (retur sudah berupa baris negatif).
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW `view_product_report` AS
SELECT
    d.product_id                    AS product_id,
    h.purchase_date                 AS date,
    d.quantity                      AS quantity,
    d.rate                          AS rate,
    'a'                             AS account,
    d.batch_id                      AS batch_id
FROM product_purchase_details d
JOIN product_purchase h ON h.purchase_id = d.purchase_id

UNION ALL

SELECT
    i.product_id                    AS product_id,
    v.date                          AS date,
    i.quantity                      AS quantity,
    i.rate                          AS rate,
    'b'                             AS account,
    i.batch_id                      AS batch_id
FROM invoice_details i
JOIN invoice v ON v.invoice_id = i.invoice_id;


-- ---------------------------------------------------------------------
-- 2) view_k_stock_batch_qty  --  kuantitas beli & jual per batch
-- ---------------------------------------------------------------------
--   Kolom yang dibutuhkan pemanggil (Reports.php):
--     product_id, batch_id, sell, Purchase
--   ("sell" dan "Purchase" persis mengikuti penamaan di query lama.)
--
--   Satu baris per kombinasi product_id + batch_id.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW `view_k_stock_batch_qty` AS
SELECT
    beli.product_id                 AS product_id,
    beli.batch_id                   AS batch_id,
    IFNULL(jual.qty, 0)             AS sell,
    beli.qty                        AS Purchase
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
