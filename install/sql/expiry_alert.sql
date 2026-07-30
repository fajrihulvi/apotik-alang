-- =============================================================
-- Notifikasi Obat Mendekati Kedaluwarsa (ambang bisa diatur)
-- Jalankan pada database `apotik_alang`.
-- =============================================================

-- 1) Kolom ambang notifikasi (dalam BULAN) di web_setting. Default 8.
ALTER TABLE `web_setting`
  ADD COLUMN `expiry_alert_months` INT(11) NOT NULL DEFAULT 8
  COMMENT 'Ambang notifikasi obat mendekati kedaluwarsa (bulan)' AFTER `discount_type`;

-- 2) Label bahasa (yang belum ada).
INSERT INTO `language` (`phrase`, `english`, `bahasa`) VALUES
('near_expiry', 'Near Expiry Medicine', 'Obat Mendekati Kedaluwarsa'),
('near_expiry_list', 'Near Expiry Medicine List', 'Daftar Obat Mendekati Kedaluwarsa'),
('expiry_alert_months', 'Expiry Alert (Months)', 'Ambang Notifikasi Kedaluwarsa (Bulan)');
