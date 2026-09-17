-- =====================================================================
-- Ganti label tombol "Daftar Pemborosan" -> "Daftar Pemusnahan Barang"
-- =====================================================================
--
-- Frasa `wastage_list` dipakai pada tombol di halaman Pengembalian
-- (application/views/return/form.php). Istilah "Pemborosan" kurang tepat
-- untuk barang rusak/kadaluarsa yang dimusnahkan; disamakan dengan istilah
-- "Pemusnahan Barang" yang dipakai fitur baru.
--
-- Dijalankan pada database aktif. Aman dijalankan berulang kali.
-- =====================================================================

UPDATE `language`
SET `english` = 'Disposal List',
    `bahasa`  = 'Daftar Pemusnahan Barang'
WHERE `phrase` = 'wastage_list';
