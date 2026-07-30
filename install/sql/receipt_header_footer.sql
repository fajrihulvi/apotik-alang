-- =============================================================
-- Manajemen Header & Footer Struk Kasir (POS)
-- Jalankan pada database `apotik_alang`.
-- =============================================================

-- 1) Kolom baru di web_setting untuk menyimpan HTML header & footer struk.
ALTER TABLE `web_setting`
  ADD COLUMN `receipt_header` TEXT NULL AFTER `footer_text`,
  ADD COLUMN `receipt_footer` TEXT NULL AFTER `receipt_header`;

-- 2) RBAC: daftarkan module di bawah Settings (mid = 16).
--    directory 'receipt_header_footer' dipakai permission1->module()/method().
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES
(210, 16, 'Receipt Header Footer', '', '', 'receipt_header_footer', 1)
ON DUPLICATE KEY UPDATE `name` = VALUES(`name`), `directory` = VALUES(`directory`), `status` = VALUES(`status`);

-- 3) Beri izin penuh (CRUD) ke role "Owner" (role_id = 1). Idempotent.
INSERT INTO `role_permission` (`fk_module_id`, `role_id`, `create`, `read`, `update`, `delete`)
SELECT 210, 1, 1, 1, 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `role_permission` WHERE `role_id` = 1 AND `fk_module_id` = 210);

-- 4) Label bahasa (EN + Indonesia).
INSERT INTO `language` (`phrase`, `english`, `bahasa`) VALUES
('receipt_header_footer', 'Receipt Header Footer', 'Header Footer Struk'),
('receipt_header', 'Receipt Header', 'Header Struk'),
('receipt_footer', 'Receipt Footer', 'Footer Struk');
