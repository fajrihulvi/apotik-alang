-- =============================================================
-- Migrasi data `supplier` (alangfarma.sql) -> `manufacturer_information`
--
-- Pemetaan kolom:
--   id_supplier     -> manufacturer_id
--   nm_supplier     -> manufacturer_name
--   tlp_supplier    -> mobile, contact, phone   (disalin ke tiga kolom)
--   alamat_supplier -> address
--   ket_supplier    -> details
--   is_pbf          -> diturunkan dari `trbmasuk`.`jenis`
--
-- Catatan is_pbf:
--   `trbmasuk`.`jenis` bersifat per-transaksi (enum 'pbf'/'nonpbf'), bukan
--   atribut supplier. Supplier ditandai is_pbf=1 bila punya MINIMAL SATU
--   transaksi pembelian dengan jenis='pbf'. Supplier tanpa transaksi
--   pembelian sama sekali otomatis is_pbf=0.
--   Supplier campuran (punya pbf & nonpbf): 7, 16, 35, 74, 77, 81, 85 -> 1.
--
--   Sumber: 79 supplier (id 6-86, tanpa 42 & 63); 30 ditandai PBF.
--
-- Prasyarat: jalankan install/sql/pbf_flag.sql lebih dulu bila kolom
--            `is_pbf` belum ada di `manufacturer_information`.
-- =============================================================

SET NAMES utf8mb4;

-- Kolom `address` bertipe varchar(255); alamat terpanjang pada data sumber
-- adalah 149 karakter sehingga tidak ada yang terpotong.

INSERT INTO `manufacturer_information`
  (`manufacturer_id`, `manufacturer_name`, `address`, `mobile`, `contact`, `phone`, `details`, `status`, `is_pbf`)
VALUES
(6, 'PT. Mandiri Medika Farma', 'Ruko Telaga Mas Blok G7-G8 Kel. Harapan Baru Bekasi', '021-88384061', '021-88384061', '021-88384061', '', 1, 1),
(7, 'PT. TEMPO', 'Jl. Raya Bekasi Km. 28 Medan Satria Pondok Ungu Bekasi', '021-8850909', '021-8850909', '021-8850909', '', 1, 1),
(8, 'PT. Keluarga Sehat', 'Bekasi', '081808763633', '081808763633', '081808763633', '', 1, 0),
(9, 'PT. BINTANG MEDIKA BEKASI FARMA', 'Taman Cikas B12 No. 5 Pekayon Jaya, Bekasi', '021-82436913', '021-82436913', '021-82436913', '', 1, 0),
(10, 'PT. SAN PRIMA SEJATI', 'Jl. Grand Prima Bintara Ruko No. 59 Bekasi Barat', '021-6599115', '021-6599115', '021-6599115', '', 1, 1),
(11, 'PT. Hanalab Medika', 'Summarecon Bekasi Ruko Ruby Blok TC-06', '0817134972', '0817134972', '0817134972', '', 1, 0),
(12, 'PT. KALLISTA PRIMA', 'Jl. Raya Pulo Ribung Kav. 5 Bekasi', '021-7198345', '021-7198345', '021-7198345', '', 1, 0),
(13, 'PT. BINA PRIMA SEJATI', 'Jl. Taman Sari Raya No. 56 GE Jakarta Barat', '021-6287410', '021-6287410', '021-6287410', '', 1, 0),
(14, 'PT. MERAPI UTAMA PHARMA', 'Jl. Pulo Buaran Raya No. 4 Blok IIE - Kav. No. 1 RW. 9 Jatinegara Cakung Jakarta 13930', '021-3141906', '021-3141906', '021-3141906', '', 1, 1),
(15, 'PT. SAPTA SARI TAMA', 'Jl. Caringin No. 40A Bojong Rawalumbu Bekasi', '', '', '', '', 1, 1),
(16, 'PT. GOGOBLI Asia Teknologi', 'Jl. Palmerah Utara No. 61A Tanah Abang Jakarta', '083890908811', '083890908811', '083890908811', '', 1, 1),
(17, 'PT. SHopee Indonesia', 'Jl. Jenderal Sudirman No.52-53, RT.5/RW.3, Senayan, Kec. Kby. Baru, Kota Jakarta Selatan', '(021) 80864200', '(021) 80864200', '(021) 80864200', '', 1, 0),
(18, 'PT. BINA SAN PRIMA', 'Jl. RA Kartini No. 14 RT. 005 RW. 001 Bekasi, 021-82438799', '021-82438799', '021-82438799', '021-82438799', '', 1, 1),
(19, 'PT. ONEMED JAKARTA', 'Jl. Letjend Suprapto, Ruko Mega Grosir Cempaka Mas blok M no.58 rt/rw 019/07, Kelurahan Sumur Batu, Kecamatan Cempaka Putih, Jakarta Pusat', 'HP/WA: 0811-3544-860', 'HP/WA: 0811-3544-860', 'HP/WA: 0811-3544-860', '', 1, 0),
(20, 'PT. TEKNOLOGI MEDIKA PRATAMA', 'Jl. Tugu Raya, Kel. Tugu, Kec. Cimanggis, Kota Depok, Jawa Barat', '-', '-', '-', '', 1, 1),
(21, 'PT. Mitrasehat Farmasindo', 'Jl. Telaga Elok V Harapa Baru Bekasi Utara', '-', '-', '-', 'Konsinyasi', 1, 0),
(22, 'PT. PARIT PADANG GLOBAL', 'Jl. Pulo Kambing II/26 KIP, Jakarta', '021-4683-4411', '021-4683-4411', '021-4683-4411', '', 1, 1),
(23, 'PT. ANUGRAH ARGON MEDICA', 'Jl. Prof. Yamin Gg. Delima No. 139 Duren Jaya Bekasi Timur', '021-82654111', '021-82654111', '021-82654111', '', 1, 1),
(24, 'PT. PENTA VALENT', 'Jl. Raya Bekasi Km. 17 No. 3 RT. 04 RW. 03 Kel. Jati Negara Kec. Cakung Jakarta Timur', '021-80808678', '021-80808678', '021-80808678', '', 1, 1),
(25, 'PT. ENSEVAL PUTERA MEGATRADING', 'Jl. Toyogiri Selatan No. 90 RT. 004 RW. 003 Bekasi', '-', '-', '-', '', 1, 1),
(26, 'PT. ANUGERAH PHARMINDO LESTARI', 'Jl. Pulolentut Kav. II E/4 KIP Jakarta', '021-4608820', '021-4608820', '021-4608820', '', 1, 1),
(27, 'PT. INDOFARMA GLOBAL MEDIKA', 'Jl. Indofarma No. 1A Cikarang Barat Bekasi', '-', '-', '-', '', 1, 0),
(28, 'PT. PRIMA PHARMINDO JAYA', 'Jl. Terusan Ketapang III Blok DD47 No. 1 Pekayon Jaya Bekasi', '-', '-', '-', '', 1, 0),
(29, 'PT. NUTRA SEHAT INDONESIA', 'Jl. Suci N0. 5-6 Kel. Susukan Ciracas Jakarta Timur', '-', '-', '-', 'Konsinyasi', 1, 0),
(30, 'PT. MENSA BINASUKSES', 'Jl. Siliwangi No. 31 Sepanjang Jaya Bekasi', '-', '-', '-', '', 1, 0),
(31, 'PT. ARINDIPHARMA SELARAS MEDIKA', 'Perumahan Telaga Bening Residence, Ruko Jl. Macan Raya  A1/3 Harapan Jaya Bekasi Utara', '021-22100877', '021-22100877', '021-22100877', '', 1, 0),
(32, 'PT. PRADIPTA CAKRAWALA PACIFIC', 'Kompleks Gading Bukit Indah Blok TA No. 30-31 Jl. Bukit Gading Raya Kelapa Gading Barat Jakarta Utara', '021-22450808', '021-22450808', '021-22450808', '', 1, 1),
(33, 'CV. SALIM HERBAL', 'Perumahan Gramapuri Bekasi', '081281886150/081285475412', '081281886150/081285475412', '081281886150/081285475412', '', 1, 0),
(34, 'CV. BHINEKA WARNA', 'Jl. Cendrawasih M5 Solobaru', '0271-622151/087735001166', '0271-622151/087735001166', '0271-622151/087735001166', 'Konsinyasi', 1, 0),
(35, 'PT. HOSANA JAYA FARMA', 'Jl. Pondasi No. 39 RT.01 RW.02 Kayu Putih Jakarta Timur ', '021-22484912', '021-22484912', '021-22484912', '', 1, 1),
(36, 'PT. MILLENIUM PHARMACON INTERNATIONAL', 'Ruko Grand Mall Blok D 20-21 Bekasi', '021-88959632', '021-88959632', '021-88959632', '', 1, 1),
(37, 'CV. FIRA HERBALINDO', 'JL. Bayan 1 RT. 002 RW. 003 No. 181 Kel. Mustika Jaya  Kec. Mustika Jaya Bekasi (Samping JNE Bayan)', '-', '-', '-', 'Konsinyasi', 1, 0),
(38, 'PT. CENTURY FRANCHISINDO UTAMA', 'Jl. Raya Bitung KM 10 Kampung Pos Bitung Curug Tangerang', '-', '-', '-', '', 1, 1),
(39, 'PT. KOKOH JAYA PERSADA', 'Jl. Pondasi No. 21C-21E Kayu Putih Pulo Gadung Jaktim', '-', '-', '-', '', 1, 0),
(40, 'Sentra Herbal', 'Perum Trias Blok F1 No. 12 (Depan Rumah Makan Padang) Wanasari Cibitung', '021-33258980', '021-33258980', '021-33258980', 'Beli Putus - Konsinyasi', 1, 0),
(41, 'PT. GEMILANG NAUFADA', 'Ruko Perum Prima Harapan Regency Jl. Boulevard Blok D No. 6 Harapan Baru Bekasi', '0812-1200-2240', '0812-1200-2240', '0812-1200-2240', '', 1, 1),
(43, 'KFTD Bekasi', 'Komp. Ruko Kalimas C/12 Jl. Chairil Anwar Bekasi 17113', '021-8807900', '021-8807900', '021-8807900', '', 1, 0),
(44, 'CV. ANUGRAH SEMESTA PERKASA', 'Regency 1 Bekasi Jl. Utama Blok K1 18A Wanasari Cibitung', '082262304178', '082262304178', '082262304178', 'Konsinyasi', 1, 0),
(45, 'Tokopedia', 'Apartemen Ciputra International, Jl. Lkr. Luar Barat No.101, Rw. Buaya, Kecamatan Cengkareng, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11740', '-', '-', '-', '-', 1, 0),
(46, 'PT. HERBANI MEDIKA NUSANTARA', 'Jl. Pulobuaran III Blok G No. 6 KIP Jaktim', '021-4603703', '021-4603703', '021-4603703', 'Konsinyasi', 1, 0),
(47, 'PT. SAKYO PUTRA PRATAMA', 'Villa Nusa Indah A-2 No. 12 RT> 002 RW> 003 Desa Bojong Kulur Gunung Putri Bogor', '', '', '', '', 1, 0),
(48, 'Grosir/Toko Lain-lain', 'Bekasi', '-', '-', '-', '', 1, 0),
(49, 'Sentra Herbal Kayuringin', 'Kayuringin Bekasi', '082124795778', '082124795778', '082124795778', '', 1, 0),
(50, 'El-Kautasr 3', 'Bekasi', '085711414998', '085711414998', '085711414998', 'BCA : 2380675261', 1, 0),
(51, 'PT. Eva Surya Pratama', 'Jl. Pondasi No. 60 & 71 Kayu Putih Pulo Gadung Jakarta Timur', '021-4700888', '021-4700888', '021-4700888', '', 1, 0),
(52, 'Haksama Multi Versa', 'Perum Taman Alamanda II Blok EE2 No. 20 Mustikajaya Bekasi', '-', '-', '-', '', 1, 0),
(53, 'PT. MEDIMART MEGA REZEKI', 'Ruko Tanah Baru Residence Blok A1 No. 01 Bogor Utara Kota Baogor', '0812-3444-7764', '0812-3444-7764', '0812-3444-7764', '', 1, 0),
(54, 'PT. PLANET EXCELENCIA PHARMACY', 'Bandung', '-', '-', '-', '', 1, 0),
(55, 'PT. MUTIARA MAJU MANDIRI', 'JL. Wijaya Kusuma IX No. 34 Depok', '021-7522688', '021-7522688', '021-7522688', '', 1, 0),
(56, 'PT. Golok Merah Kosmetik', 'Jakarta', '081280006000', '081280006000', '081280006000', 'Konsinyasi', 1, 0),
(57, 'PT. RADIANT SENTRAL NUTRINDO', 'Jl. Panjang No. 79 Blok L Duri Kelapa Jakarta 11510', '021-5638788', '021-5638788', '021-5638788', '', 1, 0),
(58, 'PT. BINTANG KENCANA ARTHA', 'Jl. Duri Kosambi Raya No. 72G Duri Kosambi Cengkreng Jakarta Barat', '021-54372181', '021-54372181', '021-54372181', '', 1, 1),
(59, 'Nabawi Herbal Indonesia', 'Sawangan Megah C20 Depok Jawa Barat', '-', '-', '-', '', 1, 0),
(60, 'PT. Madu Pramuka', 'Komplek Wiladatika, Jl. Buperta No. 1 RW>5 Cibubur Cipayung Jakarta Timur', '-', '-', '-', '', 1, 0),
(61, 'PT. Triwira Attara Adhirajasa', 'Jl. Raya Perancis Komplek Pergudangan 75 Blok M No. 6 Dadap Benda Kota Tangerang Banten', '', '', '', '', 1, 0),
(62, 'PT. Eratel Prima', 'Jl. Kalimalamg Setiadarma Bekasi', '', '', '', '', 1, 0),
(64, 'PT. Balina Agung Perkasa', 'Cabang Babelan', '-', '-', '-', '', 1, 0),
(65, 'PT. Putra Bumi Asih', 'Jl. Karya Logam No. 88 Jatimulya Tambun Selatan', '021-8811916', '021-8811916', '021-8811916', '', 1, 0),
(66, 'PT. Selaras Kusuma', 'Fatmawati Grand Center Blok 3 Kav. 325 Cilandak Barat Jakarta Selatan', '021-7659224', '021-7659224', '021-7659224', '', 1, 0),
(67, 'PT. Airlangga Jaya Mandiri', 'Ruko Sentra Aneka Niaga BlokC No. 7 Pejuang Medan Satria Bekasi', '', '', '', '', 1, 0),
(68, 'PT. SR12 Herbal Kosmetik', 'Jl. Raya Alas Tua, Pengasinan, Gunung Sindur, Bogor, Jawa Barat, 16340', '', '', '', '', 1, 0),
(69, 'PT. Daya Muda Agung', 'Jl. Pulo Kambing No. 9 KIP Jakarta Timur', '-', '-', '-', '', 1, 0),
(70, 'PT. Target Prima Lestari', 'Kp. Setu No. 28A Bintara Jaya Bekasi, 021-88968999', '021-54376668', '021-54376668', '021-54376668', '', 1, 0),
(71, 'PT. Saitec Prima Mandiri', 'Jl. Jend. Sudirman Blok C23 Kota Bekasi Jawa Barat 17143', '021-39711593/081319434370', '021-39711593/081319434370', '021-39711593/081319434370', '', 1, 0),
(72, 'Stok Awal', '', '', '', '', '', 1, 0),
(73, 'apotek bahagia', '', '', '', '', '', 1, 0),
(74, 'Ridwan Herbal', 'Jl. Taman Kerinci Raya', '', '', '', 'BCA 8420455136\r\nMANDIRI 1560009867428', 1, 1),
(75, 'Lawsim Zecha', 'Jl. Haji Ten No. 41 A RT 004, RW 001, Rawamangun, Pulogadung, 13220', '0214752920', '0214752920', '0214752920', 'BCA 5790178787', 1, 1),
(76, 'PT Marga Nusantara Jaya', 'Jl. H. Agus Salim No. 130 RT/RW 04/08, Kel. Bekasi Jaya, Kec. Bekasi Timur', '(021) 4603146', '(021) 4603146', '(021) 4603146', 'BCA 0663000362', 1, 1),
(77, 'PT Intisumber Hasil Sempurna Global', 'JL KEMANGSARI I NO 76 KEL. JATIBENING BARU KEC. PONDOK GEDE BEKASI', '02184902680', '02184902680', '02184902680', 'BCA 5271900739253\r\nMANDIRI 8981300739253', 1, 1),
(78, 'PT Antarmitra Sembada', 'Jl. Jend. Sudirman KM 32 RT 01/RW 01 Harapan Mulya Medan Satria', '02128088112', '02128088112', '02128088112', 'BCA 5780458994', 1, 1),
(79, 'KEBAYORAN PHARMA', 'Jl. Jendral Sudirman 88 blok BI/6-7 bekasi', '', '', '', '', 1, 1),
(80, 'PT KIMIA FARMA', 'Komp. Ruko Kalimas C/12 Jl. Chairil Anwar Bekasi', '', '', '', '', 1, 1),
(81, 'lamor parfum', '', '', '', '', '', 1, 1),
(82, 'organic parfum', '', '', '', '', '', 1, 0),
(83, 'Apotek Yasfi', 'Jl. Ujung Harapan Kavling Assalam III No. 19A Bahagia Babelan', '087880549284', '087880549284', '087880549284', '', 1, 1),
(84, 'PT BREGAS WARJI GROUP', 'Jl. Pakis Raya Blok BB 12 No. 7 RT 001/RW 012, Kel. Pekayon Jaya, Bekasi Selatan', '021 8216088', '021 8216088', '021 8216088', 'BRI 210101001544300', 1, 1),
(85, 'Sinkronisasi stok lebih', '', '', '', '', '', 1, 1),
(86, 'Giovan', '', '', '', '', '', 1, 0)
ON DUPLICATE KEY UPDATE
  `manufacturer_name` = VALUES(`manufacturer_name`),
  `address`           = VALUES(`address`),
  `mobile`            = VALUES(`mobile`),
  `contact`           = VALUES(`contact`),
  `phone`             = VALUES(`phone`),
  `details`           = VALUES(`details`),
  `is_pbf`            = VALUES(`is_pbf`);
