-- =============================================================
-- Master "Jenis Pembayaran" (Payment Type) - CRUD master data mandiri
-- Jalankan file ini pada database `apotik_alang`.
-- Aman dijalankan ulang (idempotent) untuk struktur & seed permission.
-- =============================================================

-- 1) Tabel master payment_type
CREATE TABLE IF NOT EXISTS `payment_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type_name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active,0=inactive',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data awal (selaras dengan nilai lama Cash/Bank, hanya sebagai contoh master)
INSERT INTO `payment_type` (`payment_type_name`, `status`)
SELECT * FROM (SELECT 'Cash Payment' AS a, 1 AS b) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `payment_type` WHERE `payment_type_name` = 'Cash Payment');

INSERT INTO `payment_type` (`payment_type_name`, `status`)
SELECT * FROM (SELECT 'Bank Payment' AS a, 1 AS b) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM `payment_type` WHERE `payment_type_name` = 'Bank Payment');

-- 2) Registrasi RBAC: sub_module di bawah module Settings (mid = 16)
--    directory dipakai oleh permission1->module()/method() di sidebar & view.
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES
(200, 16, 'Add Payment Type',  '', '', 'add_payment_type',  1),
(201, 16, 'Payment Type List', '', '', 'payment_type_list', 1),
(202, 16, 'Edit Payment Type', '', '', 'edit_payment_type', 1)
ON DUPLICATE KEY UPDATE `name` = VALUES(`name`), `directory` = VALUES(`directory`), `status` = VALUES(`status`);

-- 3) Label bahasa untuk display(). Phrase yang belum ada di tabel `language`.
--    (payment_type, status, action, home, save, update, edit, delete sudah ada.)
INSERT INTO `language` (`phrase`, `english`, `bahasa`) VALUES
('add_payment_type',  'Add Payment Type',  'Tambah Jenis Pembayaran'),
('payment_type_list', 'Payment Type List', 'Daftar Jenis Pembayaran'),
('edit_payment_type', 'Edit Payment Type', 'Ubah Jenis Pembayaran'),
('payment_type_name', 'Payment Type Name', 'Nama Jenis Pembayaran');

-- 4) Label untuk grup sidebar "Master Data"
INSERT INTO `language` (`phrase`, `english`, `bahasa`) VALUES
('master_data', 'Master Data', 'Master Data');

-- 5) Aktifkan RBAC Jenis Pembayaran untuk role "Owner" (role_id = 1) dengan akses penuh (CRUD).
--    fk_module_id: 200=add_payment_type, 201=payment_type_list, 202=edit_payment_type.
--    Idempotent: hanya insert bila belum ada.
INSERT INTO `role_permission` (`fk_module_id`, `role_id`, `create`, `read`, `update`, `delete`)
SELECT 200, 1, 1, 1, 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `role_permission` WHERE `role_id`=1 AND `fk_module_id`=200);

INSERT INTO `role_permission` (`fk_module_id`, `role_id`, `create`, `read`, `update`, `delete`)
SELECT 201, 1, 1, 1, 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `role_permission` WHERE `role_id`=1 AND `fk_module_id`=201);

INSERT INTO `role_permission` (`fk_module_id`, `role_id`, `create`, `read`, `update`, `delete`)
SELECT 202, 1, 1, 1, 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `role_permission` WHERE `role_id`=1 AND `fk_module_id`=202);
