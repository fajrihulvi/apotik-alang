-- =============================================================
-- Menu "Ambang Notifikasi Kedaluwarsa" di Master Data (akses Owner + admin)
-- Jalankan pada database `apotik_alang`.
-- =============================================================

-- 1) RBAC: sub_module di bawah Settings (mid=16). directory dipakai permission1.
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES
(211, 16, 'Expiry Alert Setting', '', '', 'expiry_alert_setting', 1)
ON DUPLICATE KEY UPDATE `name` = VALUES(`name`), `directory` = VALUES(`directory`), `status` = VALUES(`status`);

-- 2) Beri izin (read + update) ke role Owner (role_id=1). Idempotent.
INSERT INTO `role_permission` (`fk_module_id`, `role_id`, `create`, `read`, `update`, `delete`)
SELECT 211, 1, 0, 1, 1, 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `role_permission` WHERE `role_id` = 1 AND `fk_module_id` = 211);

-- 3) Label judul menu/halaman.
INSERT INTO `language` (`phrase`, `english`, `bahasa`) VALUES
('expiry_alert_setting', 'Expiry Alert Setting', 'Ambang Notifikasi Kedaluwarsa');
