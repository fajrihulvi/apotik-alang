-- =====================================================================
-- PERBAIKAN COLLATION TABEL STOCK OPNAME  (fix error 500 di hosting)
-- =====================================================================
--
-- GEJALA
--   Halaman Cstock_opname (daftar) dan Cstock_opname/opname_log memunculkan
--   error 500 di hosting, sedangkan Cstock_opname/opname_form jalan normal.
--   Error di log:
--     "Illegal mix of collations (utf8mb3_general_ci,IMPLICIT) and
--      (utf8mb3_uca1400_ai_ci,IMPLICIT) for operation '='"
--
-- SEBAB
--   Tabel stock_opname & stock_opname_details dibuat dengan CHARSET=utf8.
--   Di server hosting (MySQL/MariaDB versi baru), 'utf8' diterjemahkan ke
--   collation yang BERBEDA dari tabel lama (users, product_information).
--   Saat query mem-JOIN kolom string antar-tabel dengan collation berbeda,
--   MySQL menolaknya. Halaman opname_form tidak mem-JOIN antar-tabel,
--   makanya tetap jalan.
--
--   Kolom yang di-JOIN dan harus disamakan collation-nya:
--     stock_opname.created_by / posted_by      -> users.user_id
--     stock_opname_details.adjusted_by         -> users.user_id
--     stock_opname_details.product_id          -> product_information.product_id
--
-- STRATEGI
--   Samakan collation kolom opname dengan collation kolom PASANGAN-nya di
--   server tempat SQL ini dijalankan. Collation dibaca dinamis dari
--   information_schema, jadi file ini benar baik di lokal maupun hosting
--   tanpa perlu menebak nama collation.
--
-- Dijalankan pada database aktif (mis. u822118421_alang di hosting,
-- apotik_alang_new di lokal). Aman dijalankan berulang kali.
-- =====================================================================

-- Ambil collation kolom target di DATABASE yang sedang aktif ---------------
SET @db := DATABASE();

SET @coll_user := (
    SELECT COLLATION_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'users' AND COLUMN_NAME = 'user_id'
);
SET @cs_user := (
    SELECT CHARACTER_SET_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'users' AND COLUMN_NAME = 'user_id'
);

SET @coll_prod := (
    SELECT COLLATION_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'product_information' AND COLUMN_NAME = 'product_id'
);
SET @cs_prod := (
    SELECT CHARACTER_SET_NAME FROM information_schema.COLUMNS
    WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'product_information' AND COLUMN_NAME = 'product_id'
);

-- stock_opname.created_by  -> ikut users.user_id --------------------------
SET @sql := CONCAT(
    'ALTER TABLE `stock_opname` MODIFY `created_by` VARCHAR(15) ',
    'CHARACTER SET ', @cs_user, ' COLLATE ', @coll_user, ' NOT NULL'
);
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- stock_opname.posted_by   -> ikut users.user_id (boleh NULL) -------------
SET @sql := CONCAT(
    'ALTER TABLE `stock_opname` MODIFY `posted_by` VARCHAR(15) ',
    'CHARACTER SET ', @cs_user, ' COLLATE ', @coll_user, ' NULL'
);
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- stock_opname_details.adjusted_by -> ikut users.user_id ------------------
SET @sql := CONCAT(
    'ALTER TABLE `stock_opname_details` MODIFY `adjusted_by` VARCHAR(15) ',
    'CHARACTER SET ', @cs_user, ' COLLATE ', @coll_user, ' NOT NULL'
);
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;

-- stock_opname_details.product_id -> ikut product_information.product_id --
SET @sql := CONCAT(
    'ALTER TABLE `stock_opname_details` MODIFY `product_id` VARCHAR(100) ',
    'CHARACTER SET ', @cs_prod, ' COLLATE ', @coll_prod, ' NOT NULL'
);
PREPARE s FROM @sql; EXECUTE s; DEALLOCATE PREPARE s;
