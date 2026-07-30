-- =============================================================
-- Flag PBF (Pedagang Besar Farmasi) untuk Distributor
-- Jalankan pada database `apotik_alang`.
-- =============================================================

-- 1) Kolom penanda PBF pada tabel distributor (manufacturer_information).
--    1 = PBF (Ya), 0 = Bukan (Tidak). Default 0 -> data lama otomatis "Tidak".
ALTER TABLE `manufacturer_information`
  ADD COLUMN `is_pbf` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '1=PBF(Ya),0=Tidak' AFTER `status`;

-- 2) Label bahasa yang belum ada (yes/no/all sudah ada di tabel language).
INSERT INTO `language` (`phrase`, `english`, `bahasa`) VALUES
('pbf', 'PBF', 'PBF'),
('is_pbf', 'PBF (Pedagang Besar Farmasi)', 'PBF (Pedagang Besar Farmasi)');
