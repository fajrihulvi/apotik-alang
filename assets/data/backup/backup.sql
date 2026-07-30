#
# TABLE STRUCTURE FOR: acc_coa
#

DROP TABLE IF EXISTS `acc_coa`;

CREATE TABLE `acc_coa` (
  `HeadCode` varchar(50) NOT NULL,
  `HeadName` varchar(100) NOT NULL,
  `PHeadName` varchar(50) NOT NULL,
  `HeadLevel` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `IsTransaction` tinyint(1) NOT NULL,
  `IsGL` tinyint(1) NOT NULL,
  `HeadType` char(1) NOT NULL,
  `IsBudget` tinyint(1) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `manufacturer_id` int(11) DEFAULT NULL,
  `IsDepreciation` tinyint(1) NOT NULL,
  `DepreciationRate` decimal(18,2) NOT NULL,
  `CreateBy` varchar(50) NOT NULL,
  `CreateDate` datetime NOT NULL,
  `UpdateBy` varchar(50) NOT NULL,
  `UpdateDate` datetime NOT NULL,
  PRIMARY KEY (`HeadName`),
  KEY `customer_id` (`customer_id`),
  KEY `manufacturer_id` (`manufacturer_id`),
  KEY `HeadCode` (`HeadCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('50202', 'Account Payable', 'Current Liabilities', 2, 1, 0, 1, 'L', 0, NULL, NULL, 0, '0.00', 'admin', '2015-10-15 19:50:43', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('10203', 'Account Receivable', 'Current Asset', 2, 1, 0, 0, 'A', 0, NULL, NULL, 0, '0.00', '', '2019-08-10 11:01:12', 'admin', '2013-09-18 15:29:35');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('1', 'Assets', 'COA', 0, 1, 0, 0, 'A', 0, NULL, NULL, 0, '0.00', '', '2019-08-10 11:01:12', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('10201', 'Cash & Cash Equivalent', 'Current Asset', 2, 1, 0, 1, 'A', 0, NULL, NULL, 0, '0.00', '1', '2019-06-12 11:47:24', 'admin', '2015-10-15 15:57:55');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('1020102', 'Cash At Bank', 'Cash & Cash Equivalent', 3, 1, 0, 1, 'A', 0, NULL, NULL, 0, '0.00', '1', '2019-03-18 06:08:18', 'admin', '2015-10-15 15:32:42');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('1020101', 'Cash In Hand', 'Cash & Cash Equivalent', 3, 1, 1, 0, 'A', 0, NULL, NULL, 0, '0.00', '1', '2019-01-26 07:38:48', 'admin', '2016-05-23 12:05:43');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('102', 'Current Asset', 'Assets', 1, 1, 0, 0, 'A', 0, NULL, NULL, 0, '0.00', '', '2019-08-10 11:01:12', 'admin', '2018-07-07 11:23:00');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('502', 'Current Liabilities', 'Liabilities', 1, 1, 0, 0, 'L', 0, NULL, NULL, 0, '0.00', 'anwarul', '2014-08-30 13:18:20', 'admin', '2015-10-15 19:49:21');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('1020301', 'Customer Receivable', 'Account Receivable', 3, 1, 0, 1, 'A', 0, NULL, NULL, 0, '0.00', '1', '2019-01-24 12:10:05', 'admin', '2018-07-07 12:31:42');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('50204', 'Employee Ledger', 'Current Liabilities', 2, 1, 0, 1, 'L', 0, NULL, NULL, 0, '0.00', '1', '2019-04-08 10:36:32', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('404', 'Employee Salary', 'Expence', 1, 1, 1, 0, 'E', 0, NULL, NULL, 0, '0.00', '1', '2019-05-23 05:46:14', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('2', 'Equity', 'COA', 0, 1, 0, 0, 'L', 0, NULL, NULL, 0, '0.00', '', '2019-08-10 11:01:12', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('4', 'Expence', 'COA', 0, 1, 1, 0, 'E', 0, NULL, NULL, 0, '0.00', '1', '2019-06-18 11:40:41', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('405', 'Fixed Assets Cost', 'Expence', 1, 1, 1, 0, 'E', 0, NULL, NULL, 0, '0.00', '1', '2019-05-29 05:32:01', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('3', 'Income', 'COA', 0, 1, 0, 0, 'I', 0, NULL, NULL, 0, '0.00', '1', '2019-05-20 05:32:59', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('10107', 'Inventory', 'Non Current Assets', 1, 1, 0, 0, 'A', 0, NULL, NULL, 0, '0.00', '2', '2018-07-07 15:21:58', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('5', 'Liabilities', 'COA', 0, 1, 0, 0, 'L', 0, NULL, NULL, 0, '0.00', 'admin', '2013-07-04 12:32:07', 'admin', '2015-10-15 19:46:54');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('1020302', 'Loan Receivable', 'Account Receivable', 3, 1, 0, 1, 'A', 0, NULL, NULL, 0, '0.00', '1', '2019-01-26 07:37:20', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('101', 'Non Current Assets', 'Assets', 1, 1, 0, 0, 'A', 0, NULL, NULL, 0, '0.00', '', '2019-08-10 11:01:12', 'admin', '2015-10-15 15:29:11');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('501', 'Non Current Liabilities', 'Liabilities', 1, 1, 0, 0, 'L', 0, NULL, NULL, 0, '0.00', 'anwarul', '2014-08-30 13:18:20', 'admin', '2015-10-15 19:49:21');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('402', 'Product Purchase', 'Expence', 1, 1, 1, 0, 'E', 0, NULL, NULL, 0, '0.00', '1', '2019-05-20 07:46:59', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('304', 'Product Sale', 'Income', 1, 1, 1, 0, 'I', 0, NULL, NULL, 0, '0.00', '1', '2019-06-16 12:15:40', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('305', 'Service Income', 'Income', 1, 1, 1, 0, 'I', 0, NULL, NULL, 0, '0.00', '1', '2019-05-22 13:36:02', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('301', 'Store Income', 'Income', 1, 1, 0, 0, 'I', 0, NULL, NULL, 0, '0.00', '2', '2018-07-07 13:40:37', 'admin', '2015-09-17 17:00:02');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('50205', 'Supplier Ledger', 'Current Liabilities', 2, 1, 0, 1, 'L', 0, NULL, NULL, 0, '0.00', '1', '2019-10-06 06:18:49', '', '2019-08-10 11:01:12');
INSERT INTO `acc_coa` (`HeadCode`, `HeadName`, `PHeadName`, `HeadLevel`, `IsActive`, `IsTransaction`, `IsGL`, `HeadType`, `IsBudget`, `customer_id`, `manufacturer_id`, `IsDepreciation`, `DepreciationRate`, `CreateBy`, `CreateDate`, `UpdateBy`, `UpdateDate`) VALUES ('10203000001', 'Walking Customer-1', 'Customer Receivable', 4, 1, 1, 0, 'A', 0, 1, NULL, 0, '0.00', '1', '2019-11-12 07:06:55', '', '2019-08-10 00:00:00');


#
# TABLE STRUCTURE FOR: acc_transaction
#

DROP TABLE IF EXISTS `acc_transaction`;

CREATE TABLE `acc_transaction` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `VNo` varchar(50) DEFAULT NULL,
  `Vtype` varchar(50) DEFAULT NULL,
  `VDate` date DEFAULT NULL,
  `COAID` varchar(50) NOT NULL,
  `Narration` text DEFAULT NULL,
  `Debit` decimal(18,2) DEFAULT NULL,
  `Credit` decimal(18,2) DEFAULT NULL,
  `IsPosted` char(10) DEFAULT NULL,
  `CreateBy` varchar(50) DEFAULT NULL,
  `CreateDate` datetime DEFAULT NULL,
  `UpdateBy` varchar(50) DEFAULT NULL,
  `UpdateDate` datetime DEFAULT NULL,
  `IsAppove` char(10) DEFAULT NULL,
  UNIQUE KEY `ID` (`ID`),
  KEY `COAID` (`COAID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

#
# TABLE STRUCTURE FOR: asset_purchase
#

DROP TABLE IF EXISTS `asset_purchase`;

CREATE TABLE `asset_purchase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `p_date` date NOT NULL,
  `supplier_id` varchar(30) NOT NULL,
  `grand_total` float NOT NULL,
  `payment_type` tinyint(4) DEFAULT NULL,
  `bank_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: attendance
#

DROP TABLE IF EXISTS `attendance`;

CREATE TABLE `attendance` (
  `att_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `sign_in` varchar(30) NOT NULL,
  `sign_out` varchar(30) NOT NULL,
  `staytime` varchar(30) NOT NULL,
  PRIMARY KEY (`att_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: bank_add
#

DROP TABLE IF EXISTS `bank_add`;

CREATE TABLE `bank_add` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_id` varchar(50) NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `ac_name` varchar(250) DEFAULT NULL,
  `ac_number` varchar(250) DEFAULT NULL,
  `branch` varchar(250) DEFAULT NULL,
  `signature_pic` varchar(250) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: company_information
#

DROP TABLE IF EXISTS `company_information`;

CREATE TABLE `company_information` (
  `company_id` varchar(50) NOT NULL,
  `company_name` varchar(250) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `mobile` varchar(30) NOT NULL,
  `website` varchar(50) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `company_information` (`company_id`, `company_name`, `email`, `address`, `mobile`, `website`, `status`) VALUES ('NOILG8EGCRXXBWUEUQBM', 'bdtask Shop', 'bdtask@gmail.com', 'B-25, Mannan Plaza, 4th Floor, Khilkhet\r\nDhaka-1229, Bangladesh ', '1922296392', 'http://www.bdtask.com', 1);


#
# TABLE STRUCTURE FOR: currency_tbl
#

DROP TABLE IF EXISTS `currency_tbl`;

CREATE TABLE `currency_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_name` varchar(50) NOT NULL,
  `icon` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `currency_tbl` (`id`, `currency_name`, `icon`) VALUES (1, 'Taka', 'à§³');
INSERT INTO `currency_tbl` (`id`, `currency_name`, `icon`) VALUES (2, 'Dollar', '$');


#
# TABLE STRUCTURE FOR: customer_information
#

DROP TABLE IF EXISTS `customer_information`;

CREATE TABLE `customer_information` (
  `customer_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(255) DEFAULT NULL,
  `customer_address` varchar(255) NOT NULL,
  `address2` text DEFAULT NULL,
  `customer_mobile` varchar(100) NOT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `email_address` varchar(200) DEFAULT NULL,
  `contact` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `fax` varchar(100) DEFAULT NULL,
  `city` text DEFAULT NULL,
  `state` text DEFAULT NULL,
  `zip` varchar(50) DEFAULT NULL,
  `country` varchar(250) DEFAULT NULL,
  `status` int(2) NOT NULL COMMENT '1=paid,2=credit',
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `create_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `customer_information` (`customer_id`, `customer_name`, `customer_address`, `address2`, `customer_mobile`, `customer_email`, `email_address`, `contact`, `phone`, `fax`, `city`, `state`, `zip`, `country`, `status`, `create_date`, `create_by`) VALUES ('1', 'Walking Customer', '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2020-07-22 23:17:45', NULL);


#
# TABLE STRUCTURE FOR: daily_closing
#

DROP TABLE IF EXISTS `daily_closing`;

CREATE TABLE `daily_closing` (
  `closing_id` varchar(255) NOT NULL,
  `last_day_closing` float NOT NULL,
  `cash_in` float NOT NULL,
  `cash_out` float NOT NULL,
  `date` varchar(50) NOT NULL,
  `amount` float NOT NULL,
  `adjustment` float NOT NULL,
  `status` int(2) NOT NULL,
  PRIMARY KEY (`closing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: designation
#

DROP TABLE IF EXISTS `designation`;

CREATE TABLE `designation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `designation` varchar(150) NOT NULL,
  `details` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: employee_history
#

DROP TABLE IF EXISTS `employee_history`;

CREATE TABLE `employee_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `designation` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `rate_type` int(11) NOT NULL,
  `hrate` float NOT NULL,
  `email` varchar(50) NOT NULL,
  `blood_group` varchar(10) NOT NULL,
  `address_line_1` text NOT NULL,
  `address_line_2` text NOT NULL,
  `image` text DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `zip` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: employee_salary_payment
#

DROP TABLE IF EXISTS `employee_salary_payment`;

CREATE TABLE `employee_salary_payment` (
  `emp_sal_pay_id` int(11) NOT NULL AUTO_INCREMENT,
  `generate_id` int(11) NOT NULL,
  `employee_id` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `total_salary` decimal(18,2) NOT NULL DEFAULT 0.00,
  `total_working_minutes` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `working_period` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `payment_due` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `payment_date` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `paid_by` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `salary_month` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`emp_sal_pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: employee_salary_setup
#

DROP TABLE IF EXISTS `employee_salary_setup`;

CREATE TABLE `employee_salary_setup` (
  `e_s_s_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sal_type` varchar(30) NOT NULL,
  `salary_type_id` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `create_date` date DEFAULT NULL,
  `update_date` datetime(6) DEFAULT NULL,
  `update_id` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gross_salary` float NOT NULL,
  PRIMARY KEY (`e_s_s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: expense
#

DROP TABLE IF EXISTS `expense`;

CREATE TABLE `expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `type` varchar(100) NOT NULL,
  `voucher_no` varchar(50) NOT NULL,
  `amount` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: expense_item
#

DROP TABLE IF EXISTS `expense_item`;

CREATE TABLE `expense_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_item_name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: fixed_assets
#

DROP TABLE IF EXISTS `fixed_assets`;

CREATE TABLE `fixed_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_code` varchar(50) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `price` float NOT NULL,
  `insert_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: invoice
#

DROP TABLE IF EXISTS `invoice`;

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `invoice` bigint(20) DEFAULT NULL,
  `total_discount` decimal(10,2) DEFAULT 0.00 COMMENT 'total invoice discount',
  `invoice_discount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_tax` decimal(10,2) DEFAULT 0.00,
  `prevous_due` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sales_by` varchar(30) DEFAULT NULL,
  `invoice_details` varchar(200) DEFAULT NULL,
  `status` int(2) NOT NULL,
  `payment_type` int(11) NOT NULL DEFAULT 1,
  `bank_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `invoice` (`invoice`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: invoice_details
#

DROP TABLE IF EXISTS `invoice_details`;

CREATE TABLE `invoice_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_details_id` varchar(30) NOT NULL,
  `invoice_id` bigint(20) NOT NULL,
  `product_id` varchar(100) NOT NULL,
  `batch_id` varchar(30) NOT NULL,
  `cartoon` float DEFAULT NULL,
  `quantity` float NOT NULL,
  `rate` decimal(12,2) DEFAULT NULL,
  `manufacturer_rate` decimal(10,2) DEFAULT NULL,
  `total_price` decimal(12,2) DEFAULT NULL,
  `discount` decimal(12,0) DEFAULT NULL,
  `tax` decimal(10,2) DEFAULT NULL,
  `paid_amount` decimal(12,0) DEFAULT NULL,
  `due_amount` decimal(10,2) DEFAULT NULL,
  `status` int(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `product_id` (`product_id`),
  KEY `batch_id` (`batch_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: language
#

DROP TABLE IF EXISTS `language`;

CREATE TABLE `language` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `phrase` text NOT NULL,
  `english` text DEFAULT NULL,
  `bahasa` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=961 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (1, 'user_profile', 'User Profile', 'Profil pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (2, 'setting', 'Web Setting', 'Pengaturan Web');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (3, 'language', 'Language', 'Bahasa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (4, 'manage_users', 'Manage Users', 'Kelola Pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (5, 'add_user', 'Add User', 'Tambahkan pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (6, 'manage_company', 'Manage Company', 'Kelola Perusahaan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (7, 'web_settings', 'Software Settings', 'Pengaturan Perangkat Lunak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (8, 'manage_accounts', 'Manage Accounts', 'Mengelola akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (9, 'create_accounts', 'Create Accounts', 'Buat Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (10, 'manage_bank', 'Manage Bank', 'Kelola Bank');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (11, 'add_new_bank', 'Add New Bank', 'Tambahkan Bank Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (12, 'settings', 'Settings', 'Pengaturan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (13, 'closing_report', 'Closing Report', 'Laporan Penutupan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (14, 'closing', 'Closing', 'Penutupan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (15, 'cheque_manager', 'Cheque Manager', 'Periksa Manajer');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (16, 'accounts_summary', 'Accounts Summary', 'Ringkasan Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (17, 'expense', 'Expense', 'Biaya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (18, 'income', 'Income', 'Pendapatan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (19, 'accounts', 'Accounts', 'Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (20, 'stock_report', 'Stock Report', 'Laporan Stok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (21, 'stock', 'Stock', 'Persediaan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (22, 'pos_invoice', 'POS Invoice', 'Faktur POS');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (23, 'manage_invoice', 'Manage Invoice ', 'Kelola Faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (24, 'new_invoice', 'New Invoice', 'Faktur Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (25, 'invoice', 'Invoice', 'Faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (26, 'manage_purchase', 'Manage Purchase', 'Kelola Pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (27, 'add_purchase', 'Add Purchase', 'Tambahkan Pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (28, 'purchase', 'Purchase', 'Pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (29, 'paid_customer', 'Paid Customer', 'Pelanggan Berbayar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (30, 'manage_customer', 'Manage Customer', 'Kelola Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (31, 'add_customer', 'Add Customer', 'Tambahkan Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (32, 'customer', 'Customer', 'Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (33, 'manufacturer_payment_actual', 'Manufacturer Payment Actual', 'Manufacturer Payment Actual');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (34, 'manufacturer_sales_summary', 'Manufacturer  Sales Summary', 'Ringkasan Penjualan Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (35, 'manufacturer_sales_details', 'Manufacturer Sales Details', 'Rincian Penjualan Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (36, 'manufacturer_ledger', 'Manufacturer Ledger', 'Buku Besar Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (37, 'manage_manufacturer', 'Manage Manufacturer', 'Kelola Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (38, 'add_manufacturer', 'Add Manufacturer', 'Tambahkan Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (39, 'manufacturer', 'Manufacturer', 'Pabrikan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (40, 'product_statement', 'Medicine Statement', 'Pernyataan Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (41, 'manage_product', 'Manage Medicine', 'Kelola Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (42, 'add_product', 'Add Medicine', 'Tambahkan Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (43, 'product', 'Medicine', 'Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (44, 'manage_category', 'Manage Category', 'Kelola Kategori');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (45, 'add_category', 'Add Category', 'Tambahkan kategori');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (46, 'category', 'Category', 'Kategori');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (47, 'sales_report_product_wise', 'Sales Report (Medicine Wise)', 'Laporan penjualan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (48, 'purchase_report', 'Purchase Report', 'Laporan Pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (49, 'sales_report', 'Sales Report', 'Laporan penjualan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (50, 'todays_report', 'Todays Report', 'Laporan Hari Ini');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (51, 'report', 'Report', 'Laporan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (52, 'dashboard', 'Dashboard', 'Dashboard');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (53, 'online', 'Online', 'Aktif');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (54, 'logout', 'Logout', 'Keluar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (56, 'total_purchase', 'Total Purchase', 'Total Pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (57, 'total_amount', 'Total Amount', 'Jumlah total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (58, 'manufacturer_name', 'Manufacturer  Name', 'Nama pabrik');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (59, 'invoice_no', 'Invoice No', 'Nomor faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (60, 'purchase_date', 'Purchase Date', 'Tanggal Pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (61, 'todays_purchase_report', 'Todays Purchase Report', 'Laporan Pembelian Hari Ini');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (62, 'total_sales', 'Total Sales', 'Total Penjualan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (63, 'customer_name', 'Customer Name', 'Nama Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (64, 'sales_date', 'Sales Date', 'Tanggal Penjualan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (65, 'todays_sales_report', 'Todays Sales Report', 'Laporan Penjualan Hari Ini');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (66, 'home', 'Home', 'Beranda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (67, 'todays_sales_and_purchase_report', 'Todays sales and purchase report', 'Laporan penjualan dan pembelian hari ini');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (68, 'total_ammount', 'Total Amount', 'Jumlah total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (69, 'rate', 'Sale Price', 'Harga penjualan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (70, 'product_model', 'Medicine Type', 'Jenis Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (71, 'product_name', 'Medicine Name', 'Nama Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (72, 'search', 'Search', 'Cari');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (73, 'end_date', 'End Date', 'Tanggal Akhir');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (74, 'start_date', 'Start Date', 'Mulai tanggal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (75, 'total_purchase_report', 'Total Purchase Report', 'Laporan Pembelian Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (76, 'total_sales_report', 'Total Sales Report', 'Laporan Penjualan Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (77, 'total_seles', 'Total Sales', 'Total Penjualan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (78, 'all_stock_report', 'All Stock Report', 'Semua Laporan Stok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (79, 'search_by_product', 'Search By Medicine', 'Cari Berdasarkan Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (80, 'date', 'Date', 'Tanggal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (81, 'print', 'Print', 'Mencetak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (82, 'stock_date', 'Stock Date', 'Tanggal Saham');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (83, 'print_date', 'Print Date', 'Tanggal cetak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (84, 'sales', 'Sales', 'Penjualan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (85, 'price', 'Price', 'Harga');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (86, 'sl', 'SL.', 'SL.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (87, 'add_new_category', 'Add new category', 'Tambahkan kategori baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (88, 'category_name', 'Category Name', 'Nama Kategori');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (89, 'save', 'Save', 'Menyimpan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (90, 'delete', 'Delete', 'Menghapus');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (91, 'update', 'Update', 'Memperbarui');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (92, 'action', 'Action', 'Tindakan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (93, 'manage_your_category', 'Manage your category ', 'Kelola kategori Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (94, 'category_edit', 'Category Edit', 'Edit Kategori');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (95, 'status', 'Status', 'Status');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (96, 'active', 'Active', 'Aktif');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (97, 'inactive', 'Inactive', 'Tidak aktif');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (98, 'save_changes', 'Save Changes', 'Simpan perubahan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (99, 'save_and_add_another', 'Save And Add Another', 'Simpan dan Tambahkan Lainnya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (100, 'model', 'Medicine Type', 'Jenis Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (101, 'manufacturer_price', 'Manufacturer Price', 'Harga Pabrikan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (102, 'sell_price', 'Sell Price', 'Harga jual');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (103, 'image', 'Image', 'Gambar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (104, 'select_one', 'Select One', 'Pilih satu');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (105, 'details', 'Details', 'Detail');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (106, 'new_product', 'New Medicine', 'Pengobatan Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (107, 'add_new_product', 'Add new medicine', 'Tambahkan obat baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (108, 'barcode', 'Barcode', 'Barcode');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (109, 'qr_code', 'Qr-Code', 'Kode QR');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (110, 'product_details', 'Medicine Details', 'Rincian Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (111, 'manage_your_product', 'Manage your medicine', 'Kelola obat Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (112, 'product_edit', 'Medicine Edit', 'Kedokteran Edit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (113, 'edit_your_product', 'Edit your medicine', 'Edit obat Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (114, 'cancel', 'Cancel', 'Membatalkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (115, 'incl_vat', 'Incl. Vat', 'Termasuk. Tong');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (116, 'money', 'Dollar', 'Dolar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (117, 'grand_total', 'Grand Total', 'Hasil akhir');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (118, 'quantity', 'Quantity', 'Kuantitas');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (119, 'product_report', 'Medicine Report', 'Laporan Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (120, 'product_sales_and_purchase_report', 'Medicine sales and purchase report', 'Laporan penjualan dan pembelian obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (121, 'previous_stock', 'Previous Stock', 'Saham Sebelumnya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (122, 'out', 'Out', 'Di luar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (123, 'in', 'In', 'Di');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (124, 'to', 'To', 'Untuk');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (125, 'previous_balance', 'Previous Balance', 'Saldo sebelumnya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (126, 'customer_address', 'Customer Address', 'Alamat pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (127, 'customer_mobile', 'Customer Mobile', 'Seluler Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (128, 'customer_email', 'Customer Email', 'Surel pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (129, 'add_new_customer', 'Add new customer', 'Tambahkan pelanggan baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (130, 'balance', 'Balance', 'Keseimbangan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (131, 'mobile', 'Mobile', 'Seluler');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (132, 'address', 'Address', 'Alamat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (133, 'manage_your_customer', 'Manage your customer', 'Kelola pelanggan Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (134, 'customer_edit', 'Customer Edit', 'Edit Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (135, 'paid_customer_list', 'Paid Customer List', 'Daftar Pelanggan Berbayar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (136, 'ammount', 'Amount', 'Jumlah');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (137, 'customer_ledger', 'Customer Ledger', 'Buku Besar Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (138, 'manage_customer_ledger', 'Manage Customer Ledger', 'Kelola Buku Besar Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (139, 'customer_information', 'Customer Information', 'Informasi pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (140, 'debit_ammount', 'Debit Amount', 'Jumlah Debit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (141, 'credit_ammount', 'Credit Amount', 'Jumlah kredit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (142, 'balance_ammount', 'Balance Amount', 'Jumlah Saldo');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (143, 'receipt_no', 'Receipt NO', 'Receipt NO');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (144, 'description', 'Description', 'Deskripsi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (145, 'debit', 'Debit', 'Debet');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (146, 'credit', 'Credit', 'Kredit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (147, 'item_information', 'Item Information', 'Informasi barang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (148, 'total', 'Total', 'Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (149, 'please_select_manufacturer', 'Please Select Manufacturer', 'Silakan Pilih Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (150, 'submit', 'Submit', 'Kirimkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (151, 'submit_and_add_another', 'Submit And Add Another One', 'Kirim dan Tambahkan Satu Lagi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (152, 'add_new_item', 'Add New Item', 'Tambahkan Item Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (153, 'manage_your_purchase', 'Manage your purchase', 'Kelola pembelian Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (154, 'purchase_edit', 'Purchase Edit', 'Beli Edit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (155, 'purchase_ledger', 'Purchase Ledger', 'Beli Buku Besar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (156, 'invoice_information', 'Invoice Information', 'Informasi Faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (157, 'paid_ammount', 'Paid Amount', 'Jumlah pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (158, 'discount', 'Discount / Pcs.', 'Diskon / Pcs.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (159, 'save_and_paid', 'Save And Paid', 'Simpan dan Bayar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (160, 'payee_name', 'Payee Name', 'Nama Penerima Pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (161, 'manage_your_invoice', 'Manage your invoice', 'Kelola faktur Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (162, 'invoice_edit', 'Invoice Edit', 'Edit Faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (163, 'new_pos_invoice', 'New POS invoice', 'Faktur POS baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (164, 'add_new_pos_invoice', 'Add new pos invoice', 'Tambahkan faktur pos baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (165, 'product_id', 'Medicine ID', 'ID Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (166, 'paid_amount', 'Paid Amount', 'Jumlah pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (167, 'authorised_by', 'Authorised By', 'Diotorisasi Oleh');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (168, 'checked_by', 'Checked By', 'Diperiksa oleh');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (169, 'received_by', 'Received By', 'Diterima oleh');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (170, 'prepared_by', 'Prepared By', 'Disiapkan oleh');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (171, 'memo_no', 'Memo No', 'Memo No');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (172, 'website', 'Website', 'Situs web');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (173, 'email', 'Email', 'Email');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (174, 'invoice_details', 'Invoice Details', 'Detail Faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (175, 'reset', 'Reset', 'Reset');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (176, 'payment_account', 'Payment Account', 'Akun pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (177, 'bank_name', 'Bank Name', 'Nama Bank');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (178, 'cheque_or_pay_order_no', 'Cheque/Pay Order No', 'Cek / Bayar Nomor Pesanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (179, 'payment_type', 'Payment Type', 'Tipe pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (180, 'payment_from', 'Payment From', 'Pembayaran Dari');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (181, 'payment_date', 'Payment Date', 'Tanggal pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (182, 'add_income', 'Add Income', 'Tambah Pendapatan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (183, 'cash', 'Cash', 'Tunai');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (184, 'cheque', 'Cheque', 'Memeriksa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (185, 'pay_order', 'Pay Order', 'Bayar Pesanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (186, 'payment_to', 'Payment To', 'Pembayaran untuk');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (187, 'total_expense_ammount', 'Total Expense Amount', 'Jumlah Pengeluaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (188, 'transections', 'Transactions', 'Transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (189, 'accounts_name', 'Accounts Name', 'Nama Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (190, 'outflow_report', 'Expense Report', 'Laporan pengeluaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (191, 'inflow_report', 'Income Report', 'Laporan Pendapatan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (192, 'all', 'All', 'Semua');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (193, 'account', 'Account', 'Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (194, 'from', 'From', 'Dari');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (195, 'account_summary_report', 'Account Summary Report', 'Laporan Ringkasan Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (196, 'search_by_date', 'Search By Date', 'Cari Berdasarkan Tanggal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (197, 'cheque_no', 'Cheque No', 'Periksa Tidak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (198, 'name', 'Name', 'Nama');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (199, 'closing_account', 'Closing Account', 'Menutup Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (200, 'close_your_account', 'Close your account', 'Tutup akun Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (201, 'last_day_closing', 'Last Day Closing', 'Penutupan Hari Terakhir');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (202, 'cash_in', 'Cash In', 'Kas');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (203, 'cash_out', 'Cash Out', 'Kas keluar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (204, 'cash_in_hand', 'Cash In Hand', 'Uang tunai di tangan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (205, 'add_new_bank', 'Add New Bank', 'Tambahkan Bank Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (206, 'day_closing', 'Day Closing', 'Penutupan Hari');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (207, 'account_closing_report', 'Account Closing Report', 'Laporan Penutupan Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (208, 'last_day_ammount', 'Last Day Amount', 'Jumlah Hari Terakhir');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (209, 'adjustment', 'Adjustment', 'Pengaturan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (210, 'pay_type', 'Pay Type', 'Jenis Pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (211, 'customer_or_manufacturer', 'Customer,Manufacturer Or Others', 'Pelanggan, Produsen, atau Lainnya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (212, 'transection_id', 'Transactions ID', 'Transactions ID');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (213, 'accounts_summary_report', 'Accounts Summary Report', 'Laporan Ringkasan Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (214, 'bank_list', 'Bank List', 'Daftar Bank');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (215, 'bank_edit', 'Bank Edit', 'Bank Edit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (216, 'debit_plus', 'Debit (+)', 'Debet');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (217, 'credit_minus', 'Credit (-)', 'Kredit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (218, 'account_name', 'Account Name', 'Nama akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (219, 'account_type', 'Account Type', 'Jenis akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (220, 'account_real_name', 'Account Real Name', 'Nama Asli Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (221, 'manage_account', 'Manage Account', 'Kelola Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (222, 'company_name', 'Company Name', 'Nama Perusahaan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (223, 'edit_your_company_information', 'Edit your company information', 'Edit informasi perusahaan Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (224, 'company_edit', 'Company Edit', 'Perusahaan Edit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (225, 'admin', 'Admin', 'Admin');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (226, 'user', 'User', 'Pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (227, 'password', 'Password', 'Kata sandi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (228, 'last_name', 'Last Name', 'Nama keluarga');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (229, 'first_name', 'First Name', 'Nama depan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (230, 'add_new_user_information', 'Add new user information', 'Tambahkan informasi pengguna baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (231, 'user_type', 'User Type', 'Tipe Pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (232, 'user_edit', 'User Edit', 'Edit Pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (233, 'rtr', 'RTR', 'RTR');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (234, 'ltr', 'LTR', 'LTR');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (235, 'ltr_or_rtr', 'LTR/RTR', 'LTR / RTR');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (236, 'footer_text', 'Footer Text', 'Catatan kaki');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (237, 'favicon', 'Favicon', 'Favicon');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (238, 'logo', 'Logo', 'Logo');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (239, 'update_setting', 'Update Setting', 'Perbarui Pengaturan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (240, 'update_your_web_setting', 'Update your Web setting', 'Perbarui setelan Web Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (241, 'login', 'Login', 'Gabung');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (242, 'your_strong_password', 'Your strong password', 'Kata sandi kuat Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (243, 'your_unique_email', 'Your unique email', 'Email unik Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (244, 'please_enter_your_login_information', 'Please enter your login information.', 'Masukkan informasi login Anda.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (245, 'update_profile', 'Update Profile', 'Memperbaharui profil');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (246, 'your_profile', 'Your Profile', 'Profil kamu');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (247, 're_type_password', 'Re-Type Password', 'Ketik Ulang Kata Sandi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (248, 'new_password', 'New Password', 'Kata sandi baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (249, 'old_password', 'Old Password', 'Password lama');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (250, 'new_information', 'New Information', 'Informasi baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (251, 'old_information', 'Old Information', 'Informasi Lama');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (252, 'change_your_information', 'Change your information', 'Ubah informasi Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (253, 'change_your_profile', 'Change your profile', 'Ubah profil Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (254, 'profile', 'Profile', 'Profil');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (255, 'wrong_username_or_password', 'Wrong User Name Or Password !', 'Username atau password salah !');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (256, 'successfully_updated', 'Successfully Updated.', 'Berhasil diperbarui.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (257, 'blank_field_does_not_accept', 'Blank Field Does Not Accept !', 'Bidang Kosong Tidak Menerima!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (258, 'successfully_changed_password', 'Successfully changed password.', 'Berhasil mengubah kata sandi.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (259, 'you_are_not_authorised_person', 'You are not authorised person !', 'Kamu bukan orang yang berwenang!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (260, 'password_and_repassword_does_not_match', 'Passwor and re-password does not match !', 'Kata sandi dan sandi ulang tidak cocok!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (261, 'new_password_at_least_six_character', 'New Password At Least 6 Character.', 'Kata Sandi Baru Minimal 6 Karakter.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (262, 'you_put_wrong_email_address', 'You put wrong email address !', 'Anda memasukkan alamat email yang salah!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (263, 'cheque_ammount_asjusted', 'Cheque amount adjusted.', 'Periksa jumlah yang disesuaikan.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (264, 'successfully_payment_paid', 'Successfully Payment Paid.', 'Pembayaran Berhasil Dibayar.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (265, 'successfully_added', 'Successfully Added.', 'Berhasil ditambahkan.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (266, 'successfully_updated_2_closing_ammount_not_changeale', 'Successfully Updated -2. Note: Closing Amount Not Changeable.', 'Berhasil Diperbarui -2. Catatan: Jumlah Penutupan Tidak Berubah. ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (267, 'successfully_payment_received', 'Successfully Payment Received.', 'Pembayaran Berhasil Diterima.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (268, 'already_inserted', 'Already Inserted !', 'Sudah Disisipkan!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (269, 'successfully_delete', 'Successfully Delete.', 'Berhasil Hapus.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (270, 'successfully_created', 'Successfully Created.', 'Berhasil Dibuat.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (271, 'logo_not_uploaded', 'Logo not uploaded !', 'Logo tidak diunggah!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (272, 'favicon_not_uploaded', 'Favicon not uploaded !', 'Favicon belum diupload!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (273, 'manufacturer_mobile', 'Manufacturer  Mobile', 'Produsen Seluler');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (274, 'manufacturer_address', 'Manufacturer  Address', 'Alamat Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (275, 'manufacturer_details', 'Manufacturer Details', 'Detail Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (276, 'add_new_manufacturer', 'Add New Manufacturer', 'Tambahkan Produsen Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (277, 'manage_suppiler', 'Manage Manufacturer', 'Kelola Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (278, 'manage_your_manufacturer', 'Manage your Manufacturer', 'Kelola Produsen Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (279, 'manage_manufacturer_ledger', 'Manage Manufacturer', 'Kelola Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (280, 'invoice_id', 'Invoice ID', 'ID faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (281, 'deposite_id', 'Deposit ID', 'ID Deposit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (282, 'manufacturer_actual_ledger', 'Manufacturer Actual Ledger', 'Manufacturer Actual Ledger');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (283, 'manufacturer_information', 'Manufacturer Information', 'Informasi Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (284, 'event', 'Event', 'Peristiwa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (285, 'add_new_income', 'Add New Income', 'Tambahkan Pendapatan Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (286, 'add_expese', 'Add Expense', 'Tambah Biaya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (287, 'add_new_expense', 'Add New Expense', 'Tambahkan Pengeluaran Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (288, 'total_income_ammount', 'Total Income Amount', 'Jumlah Pendapatan Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (289, 'create_new_invoice', 'Create New Invoice', 'Buat Faktur Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (290, 'create_pos_invoice', 'Create POS Invoice', 'Buat Faktur POS');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (291, 'total_profit', 'Total Profit', 'Total keuntungan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (292, 'monthly_progress_report', 'Monthly Progress Report', 'Laporan Bulanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (293, 'total_invoice', 'Total Invoice', 'Total Faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (294, 'account_summary', 'Account Summary', 'Ringkasan Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (295, 'total_manufacturer', 'Total manufacturer', 'Total Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (296, 'total_product', 'Total Medicine', 'Total Medicine');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (297, 'total_customer', 'Total Customer', 'Total Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (298, 'manufacturer_edit', 'Manufacturer Edit', 'Produsen Edit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (299, 'add_new_invoice', 'Add New Invoice', 'Tambahkan Faktur Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (300, 'add_new_purchase', 'Add new purchase', 'Tambahkan pembelian baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (301, 'currency', 'Currency', 'Mata uang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (302, 'currency_position', 'Currency Position', 'Posisi Mata Uang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (303, 'left', 'Left', 'Kiri');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (304, 'right', 'Right', 'Kanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (305, 'add_tax', 'Add Tax', 'Tambahkan Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (306, 'manage_tax', 'Manage Tax', 'Kelola Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (307, 'add_new_tax', 'Add new tax', 'Tambahkan pajak baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (308, 'enter_tax', 'Enter Tax', 'Masukkan Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (309, 'already_exists', 'Already Exists !', 'Sudah ada !');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (310, 'successfully_inserted', 'Successfully Inserted.', 'Berhasil Dimasukkan.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (311, 'tax', 'Tax', 'Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (312, 'tax_edit', 'Tax Edit', 'Edit Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (313, 'product_not_added', 'Medicine not added !', 'Obat tidak ditambahkan!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (314, 'total_tax', 'Total Tax', 'Pajak Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (315, 'manage_your_manufacturer_details', 'Manage your Manufacturer', 'Kelola Produsen Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (316, 'invoice_description', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry', 'Lorem Ipsum has been the industry');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (317, 'thank_you_for_choosing_us', 'Thank you very much for choosing us', 'Terima kasih banyak telah memilih kami');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (318, 'billing_date', 'Billing Date', 'Tanggal tagihan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (319, 'billing_to', 'Billing To', 'Billing To');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (320, 'billing_from', 'Billing From', 'Billing From');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (321, 'you_cant_delete_this_product', 'Sorry !!  You can not delete this medicine.This medicine already used in calculation system!', 'Maaf !! Anda tidak bisa menghapus obat ini. Obat ini sudah digunakan dalam sistem kalkulasi! ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (322, 'old_customer', 'Old Customer', 'Pelanggan Lama');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (323, 'new_customer', 'New Customer', 'Pelanggan baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (324, 'new_manufacturer', 'New Manufacturer', 'Produsen Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (325, 'old_manufacturer', 'Old Manufacturer', 'Produsen Lama');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (326, 'credit_customer', 'Credit Customer', 'Kredit Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (327, 'account_already_exists', 'This Account Already Exists !', 'Akun ini sudah ada !');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (328, 'edit_income', 'Edit Income', 'Edit Pendapatan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (329, 'you_are_not_access_this_part', 'You are not authorised person !', 'Kamu bukan orang yang berwenang!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (330, 'account_edit', 'Account Edit', 'Edit Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (331, 'due', 'Due', 'Jatuh Tempo');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (332, 'expense_edit', 'Expense Edit', 'Biaya Edit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (333, 'please_select_customer', 'Please select customer !', 'Pilih pelanggan!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (334, 'profit_report', 'Profit Report (Invoice Wise)', 'Laporan Laba');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (335, 'total_profit_report', 'Total profit report', ' Laporan laba total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (336, 'please_enter_valid_captcha', 'Please enter valid captcha.', 'Harap masukkan captcha yang valid.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (337, 'category_not_selected', 'Category not selected.', 'Kategori tidak dipilih.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (338, 'manufacturer_not_selected', 'Manufacturer not selected.', 'Produsen tidak dipilih.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (339, 'please_select_product', 'Please select medicine', 'Silakan pilih obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (340, 'product_model_already_exist', 'Medicine model already exist !', 'Model obat sudah ada!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (341, 'invoice_logo', 'Invoice Logo', 'Logo Faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (342, 'available_quantity', 'Available Quantity', 'Kuantitas Tersedia');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (343, 'you_can_not_buy_greater_than_available_quantity', 'You can not select grater than availale quantity !', 'Anda tidak dapat memilih parutan daripada jumlah yang tersedia!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (344, 'customer_details', 'Customer details', 'Detil pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (345, 'manage_customer_details', 'Manage customer details.', 'Kelola detail pelanggan.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (346, 'box_size', 'Box size', 'Ukuran kotak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (347, 'expire_date', 'Expiry  date', 'Tanggal kadaluarsa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (348, 'product_location', 'Medicine  Shelf', 'Rak Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (349, 'generic_name', 'Generic name', 'Nama generik');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (350, 'payment_method', 'Payment Method', 'Cara Pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (351, 'card_no', 'Card no', 'Kartu no');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (352, 'medicine', 'Medicine', 'Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (353, 'medicine_search', 'Medicine Search', 'Pencarian Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (354, 'what_you_search', 'Enter what you search', 'Masukkan apa yang Anda cari');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (355, 'company', 'Company', 'Perusahaan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (356, 'customer_search', 'Customer search', 'Pencarian pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (357, 'invoice_search', 'Invoice search', 'Pencarian faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (358, 'purchase_search', 'Purchase search', 'Pencarian pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (359, 'daily_closing_report', 'Daily closing report.', 'Laporan penutupan harian.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (360, 'closing_search_report', 'Closing Search Report', 'Menutup Laporan Pencarian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (361, 'category_list', 'Category List', 'Daftar Kategori');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (362, 'company_list', 'Company List', 'Daftar Perusahaan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (363, 'customers_list', 'Customer List', 'Daftar pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (364, 'credit_customer_list', 'Credit Customer List', 'Daftar Pelanggan Kredit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (365, 'previous_balance_adjustment', 'Previous Balance Adjustment', 'Penyesuaian Saldo Sebelumnya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (366, 'invoice_list', 'Invoice List', 'Daftar Faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (367, 'add_pos_invoice', 'Add POS Invoice', 'Tambahkan Faktur POS');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (368, 'add_invoice', 'Add Invoice', 'Tambahkan Faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (369, 'product_list', 'Medicine List', 'Daftar Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (370, 'purchases_list', 'Purchase List', 'Daftar Pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (371, 'purchase_list', 'Purchase List', 'Daftar Pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (372, 'stock_list', 'Stock List', 'Daftar Saham');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (373, 'all_report', 'All Report', 'Semua Laporan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (374, 'daily_sales_report', 'Daily sales Report', 'Laporan Penjualan Harian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (375, 'product_wise_sales_report', 'Medicine Wise Sales Report', 'Laporan Penjualan yang Bijaksana Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (376, 'bank_update', 'Bank Update', 'Pembaruan Bank');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (377, 'account_list', 'Account List', 'Daftar Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (378, 'manufacturer_list', 'Manufacturer  List', 'Daftar Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (379, 'manufacturer_search_item', 'Manufacturer  Search Item', 'Item Penelusuran Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (380, 'user_list', 'User List', 'Daftar pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (381, 'user_search_item', 'User Search Item', 'Item Pencarian Pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (382, 'change_password', 'Change Password', 'Ganti kata sandi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (383, 'admin_login_area', 'Admin Login Area', 'Admin Login Area');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (384, 'accounts_inflow_form', 'Account Inflow Form', 'Formulir Arus Masuk Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (385, 'accounts_outflow_form', 'Accounts Outflow Form', 'Formulir Arus Keluar Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (386, 'accounts_tax_form', 'Accounts Tax Form', 'Formulir Pajak Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (387, 'accounts_manage_tax', 'Accounts Manage Tax', 'Kelola Akun Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (388, 'accounts_tax_edit', 'Accounts Tax Edit', 'Edit Pajak Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (389, 'accounts_summary_data', 'Accounts Summary Data', 'Data Ringkasan Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (390, 'accounts_details_data', 'Accounts Details Data', 'Data Detail Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (391, 'datewise_summary_data', 'Datewise Summary Data', 'Data Ringkasan Data');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (392, 'accounts_cheque_manager', 'Account Cheque Manager', 'Manajer Pemeriksaan Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (393, 'accounts_edit_data', 'Accounts Edit Data', 'Data Edit Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (394, 'print_barcode', 'Print Barcode', 'Cetak Barcode');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (395, 'print_qrcode', 'Print Qrcode', 'Cetak QRCode');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (396, 'add_new_account', 'Add New Account', 'Tambahkan Akun Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (397, 'table_edit', 'Table Edit', 'Edit Tabel');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (398, 'secret_key', 'Secret Key', 'Kunci rahasia');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (399, 'site_key', 'Site Key', 'Kunci Situs');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (400, 'captcha', 'Captcha', 'Captcha');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (401, 'please_add_walking_customer_for_default_customer', 'Please add walking customer for default customer. ', 'Harap tambahkan pelanggan berjalan untuk pelanggan default. ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (402, 'barcode_qrcode_scan_here', 'Barcode Or QRcode scan here', 'Pindai kode batang atau kode QR di sini');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (403, 'manage_your_credit_customer', 'Manage your credit customer', 'Kelola pelanggan kredit Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (404, 'unit', 'Unit', 'Satuan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (405, 'total_discount', 'Total Discount', 'Diskon Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (406, 'meter_m', 'Meter (M)', 'Meter');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (407, 'piece_pc', 'Piece (Pc)', 'PCS');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (408, 'kilogram_kg', 'Kilogram (Kg)', 'Kilogram');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (409, 'import_product_csv', 'Import Medicine (CSV)', 'Impor Obat (CSV)');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (410, 'close', 'Close', 'Tutup');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (411, 'csv_file_informaion', 'File Information (CSV)', 'Informasi File');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (412, 'download_example_file', 'Download Example File', 'Unduh Contoh File ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (413, 'upload_csv_file', 'Upload CSV File', 'Unggah File CSV');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (414, 'manufacturer_id', 'Manufacturer ID', 'ID Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (415, 'category_id', 'Category ID', 'ID Kategori');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (416, 'are_you_sure_to_delete', 'Are you sure,want to delete ?', 'Apakah Anda yakin ingin menghapus?');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (417, 'stock_report_manufacturer_wise', 'Stock Report (Manufacturer Wise)', 'Laporan Stok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (418, 'stock_report_product_wise', 'Stock Report (Medicine Wise)', 'Laporan Stok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (419, 'select_manufacturer', 'Select Manufacturer', 'Pilih Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (420, 'select_product', 'Select Medicine ', 'Pilih Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (421, 'phone', 'Phone', 'Telepon');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (422, 'in_quantity', 'In Quantity', 'Dalam Kuantitas');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (423, 'out_quantity', 'Sold QTY', 'Terjual QTY');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (424, 'in_taka', 'In Taka', 'Di Taka');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (425, 'out_taka', 'Out Taka', 'Keluar Taka');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (426, 'data_synchronizer', 'Data Synchronizer', 'Sinkronisasi Data');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (427, 'synchronize', 'Synchronize', 'Sinkronisasi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (428, 'backup_restore', 'Backup And Restore', 'Cadangkan dan Pulihkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (429, 'synchronizer_setting', 'Synchronizer Setting', 'Pengaturan Sinkronisasi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (430, 'backup_and_restore', 'Backup And Restore', 'Cadangkan dan Pulihkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (431, 'hostname', 'Host Name', 'Nama Host');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (432, 'username', 'User Name', 'Nama pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (433, 'ftp_port', 'FTP Port', 'Port FTP');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (434, 'ftp_debug', 'FTP Debug', 'FTP Debug');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (435, 'project_root', 'Project Root', 'Project Root');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (436, 'internet_connection', 'Internet connection', 'Koneksi internet');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (437, 'ok', 'Ok', 'Baik');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (438, 'not_available', 'Not available', 'Tidak tersedia');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (439, 'outgoing_file', 'Outgoing File', 'File Keluar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (440, 'available', 'Available', 'Tersedia');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (441, 'incoming_file', 'Incoming file', 'File masuk');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (442, 'data_upload_to_server', 'Data upload to server', 'Unggah data ke server');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (443, 'download_data_from_server', 'Download data from server', 'Unduh data dari server');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (444, 'data_import_to_database', 'Data import to database', 'Impor data ke database');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (445, 'please_wait', 'Please Wait', 'Mohon tunggu');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (446, 'ooops_something_went_wrong', 'Ooops something went wrong', 'Ups, ada yang tidak beres');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (447, 'file_information', 'File Information', 'Informasi File');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (448, 'size', 'Size', 'Ukuran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (449, 'backup_date', 'Backup date', 'Tanggal cadangan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (450, 'backup_now', 'Backup Now', 'Cadangkan Sekarang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (451, 'are_you_sure', 'Are you sure ?', 'Apakah kamu yakin?');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (452, 'download', 'Downlaod', 'Downlaod');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (453, 'database_backup', 'Database Backup', 'Pencadangan Database');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (454, 'backup_successfully', 'Backup Successfully', 'Cadangan Berhasil');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (455, 'please_try_again', 'Please Try Again', 'Silakan Coba Lagi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (456, 'restore_successfully', 'Restore successfully', 'Berhasil pulih');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (457, 'download_successfully', 'Download Successfully', 'Unduh Berhasil');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (458, 'delete_successfully', 'Delete Successfully', 'Hapus Berhasil');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (459, 'ftp_setting', 'FTP Setting', 'Pengaturan FTP');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (460, 'save_successfully', 'Save successfully', 'Berhasil disimpan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (461, 'upload_successfully', 'Upload successfully.', 'Unggah berhasil.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (462, 'unable_to_upload_file_please_check_configuration', 'unable to upload file please check configuration.', 'tidak dapat mengunggah file, harap periksa konfigurasi.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (463, 'please_configure_synchronizer_settings', 'Please Configure Synchronizer Settings ', 'Harap Konfigurasikan Pengaturan Sinkronisasi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (464, 'unable_to_download_file_please_check_configuration', 'Unable To Download File,Please Check Configuration.', 'Tidak Dapat Mengunduh File, Harap Periksa Konfigurasi.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (465, 'data_import_first', 'Data Import First', 'Impor Data Dulu');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (466, 'data_import_successfully', 'Data Import Successfully', 'Impor Data Berhasil');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (467, 'unable_to_import_data_please_check_config_or_sql_file', 'Unable to import data please check config or sql file.', 'Tidak dapat mengimpor data, harap periksa file config atau sql.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (468, 'restore_now', 'Restore Now', 'Pulihkan Sekarang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (469, 'out_of_stock', 'Out Of Stock', 'Stok Habis');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (470, 'others', 'Others', 'Lainnya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (471, 'shelf', 'Shelf', 'Rak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (472, 'discount_type', 'Discount Type ', 'Jenis Diskon');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (473, 'discount_percentage', 'Discount', 'Diskon');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (474, 'fixed_dis', 'Fixed Dis', 'Fixed Dis');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (475, 'full_paid', 'Full Paid', 'Bayar Penuh');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (476, 'available_qnty', 'Ava.Qty', 'Ava.Qty');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (477, 'stock_ctn', 'Stock/Qnt', 'Stok / Qnt');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (478, 'sale_price', 'Sale Price', 'Harga penjualan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (479, 'manufacturer_rate', 'Manufacturer  Price', 'Harga Pabrikan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (480, 'please_upload_image_type', 'Sorry!!! Please Upload jpg,jpeg,png,gif typeimage', 'Maaf!!! Silakan Unggah gambar jenis jpg, jpeg, png, gif ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (481, 'ml', 'Milli liter(ml)', 'Mili liter');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (482, 'mg', 'Milli Gram(mg)', 'Milli Gram');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (483, 'you_can_not_buy_greater_than_available_qnty', 'You can not sale more than available quantity ! please purchase this Product', 'Anda tidak dapat menjual lebih dari jumlah yang tersedia! tolong beli Produk ini ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (484, 'due_amount', 'Due Amount', 'Jumlah yang Harus Dibayar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (485, 'return_invoice', 'Return Invoice', 'Return Invoice');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (486, 'sold_qty', 'Sold Qty', 'Terjual Qty');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (487, 'ret_quantity', 'Return QTY', 'Kembalikan QTY');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (488, 'deduction', 'Deduction', 'Deduksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (489, 'return', 'Return', 'Retur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (490, 'note', 'Return Reasone', 'Return Reasone');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (491, 'usablilties', 'Return Usability', 'Kembalikan Kegunaan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (492, 'adjs_with_stck', 'Adjust With Stock', 'Sesuaikan Dengan Stok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (493, 'return_to_manufacturer', 'Return To Manufacturer', 'Kembali ke Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (494, 'wastage', 'Wastage', 'Pemborosan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (495, 'to_deduction', 'Total Deduction', 'Potongan Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (496, 'nt_return', 'Net Return', 'Pengembalian Bersih');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (497, 'return_id', 'Return Id', 'Return Id');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (498, 'return_details', 'Return Details', 'Detail Pengembalian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (499, 'add_return', 'Add Return', 'Tambahkan Pengembalian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (500, 'return_list', 'Return List', 'Daftar Kembali');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (501, 'stock_return_list', 'Stock Return List', 'Daftar Pengembalian Saham');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (502, 'wastage_return_list', 'Wastage Return List', 'Daftar Pengembalian Sampah');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (503, 'check_return', 'Check Return', 'Periksa Kembali');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (504, 'quantity_must_be_fillup', 'Return Quantity Must be Fill Up', 'Kuantitas Pengembalian Harus Diisi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (505, 'expeire_date', 'Expiry  date', 'Tanggal kadaluarsa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (506, 'batch_id', 'Batch ID', 'ID Batch');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (507, 'manufacturer_return_list', 'Manufacturer  Return List', 'Daftar Pengembalian Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (508, 'c_r_slist', 'Customer Return List ', 'Daftar Pengembalian Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (509, 'manufacturer_return', 'Manufacturer  Return ', 'Pengembalian Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (510, 'wastage_list', 'Wastage List', 'Daftar Sampah');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (511, 'in_qnty', 'In Quantity', 'Dalam Kuantitas');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (512, 'out_qnty', 'Sold QTY', 'QTY Terjual');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (513, 'stock_sale', 'Stock Sell Price', 'Harga Jual Saham');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (514, 'add_product_csv', 'Import Medicine (CSV)', 'Impor Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (515, 'purchase_id', 'Purchase ID', 'ID Pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (516, 'add_payment', 'Add Payment', 'Tambahkan Pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (517, 'add_new_payment', 'Add new Payment', 'Tambahkan Pembayaran baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (518, 'transaction', 'Transaction', 'Transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (519, 'manage_transaction', 'Manage Transaction', 'Kelola Transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (520, 'choose_transaction', 'Choose Transaction', 'Pilih Transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (521, 'receipt', 'Receipt', 'Resi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (522, 'payment', 'Payment', 'Pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (523, 'transaction_categry', 'Transaction Category', 'Kategori Transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (524, 'transaction_mood', 'Transaction Mood', 'Transaction Mood');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (525, 'payment_amount', 'Payment Amount', 'Jumlah pembayaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (526, 'receipt_amount', 'Receipt Amount', 'Jumlah Tanda Terima');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (527, 'daily_summary', 'Daily Summary', 'Ringkasan Harian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (528, 'daily_cash_flow', 'Daily  Cashflow', 'Arus Kas Harian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (529, 'custom_report', 'Custom Report', 'Laporan Kustom');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (530, 'root_account', 'Root Account', 'Akun Root');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (531, 'office', 'Office', 'Kantor');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (532, 'loan', 'Loan', 'Pinjaman');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (533, 'successfully_saved', 'Successfully Saved', 'Berhasil Disimpan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (534, 'bank', 'Bank', 'Bank');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (535, 'bank_transaction', 'Bank Transaction', 'Transaksi bank');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (536, 'office_loan', 'Office Loan', 'Pinjaman Kantor');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (537, 'add_person', 'Add Person', 'Tambahkan Orang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (538, 'manage_loan', 'Manage Person', 'Kelola Orang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (539, 'add_loan', 'Add Loan', 'Tambahkan Pinjaman');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (540, 'ac_name', 'Account Name', 'Nama akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (541, 'ac_no', 'Account No', 'No rekening');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (542, 'branch', 'Branch', 'Cabang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (543, 'signature_pic', 'Signature ', 'Tanda tangan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (544, 'withdraw_deposite_id', 'Withdraw Deposit ID', 'Tarik ID Setoran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (545, 'select_report', 'Select Report', 'Pilih Laporan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (546, 'per_qty', 'Purchase Qty', 'Beli Qty');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (547, 'stock_report_batch_wise', 'Stock Report(Batch Wise)', 'Laporan Saham');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (548, 'box', 'Box', 'Kotak ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (549, 'gram', 'Gram', 'Gram');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (550, 'profit_report_manufacturer_wise', 'Profit/Loss Report(Manufacturer)', 'Laporan Untung / Rugi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (551, 'calculate', 'Calculate', 'Hitung');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (552, 'profit_report_product_wise', 'Profit/Loss  Report Product Wise', 'Laporan Untung / Rugi Produk Bijak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (553, 'view_report', 'View Report', 'Melihat laporan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (554, 'report_for', 'Report For', 'Laporan untuk');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (555, 'total_sale_qty', 'Total Sale QTY', 'Total Penjualan QTY');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (556, 'total_purchase_pric', 'Total purchase Price', 'Harga Pembelian Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (557, 'total_sale', 'Total Sale', 'Penjualan Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (558, 'net_profit', 'Net Profit', 'Laba bersih');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (559, 'loss', 'Loss', 'Kerugian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (560, 'product_type', 'Medicine Type', 'Jenis Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (561, 'add_type', 'Add Medicine Type', 'Tambahkan Jenis Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (562, 'add_new_type', 'Add New Medicine  Type', 'Tambahkan Jenis Obat Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (563, 'type', 'Type', 'Tipe');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (564, 'type_name', 'Type Name', 'Ketik nama');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (565, 'manage_type', 'Manage Medicine Type', 'Kelola Jenis Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (566, 'type_id', 'Type Id', 'Type Id');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (567, 'type_edit', 'Edit Type', 'Edit Jenis');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (568, 'profitloss', 'profit/Loss', 'rugi laba');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (569, 'manufacturer_wise', 'Manufacturer Wise', 'Produsen Bijaksana');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (570, 'product_wise', 'Medicine Wise', 'Medicine Wise');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (571, 'medicine_info', 'Medicine Information', 'Informasi Kedokteran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (572, 'choose_another_invno', 'Choose Another Invoice No !!', 'Pilih Nomor Faktur Lain !!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (573, 'return_manufacturers', 'Return Manufacturers', 'Produsen Pengembalian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (574, 'return_manufacturer', 'Return Manufacturers', 'Produsen Pengembalian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (575, 'please_input_correct_invoice_no', 'Please Input Correct Invoice No', 'Harap Masukkan Nomor Faktur yang Benar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (576, 'stock_purchase_price', 'Stock Purchase Price', 'Harga Pembelian Saham');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (577, 'manufacturer_returns', 'Manufacturer  Return ', 'Pengembalian Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (578, 'invoice_discount', 'Invoice Discount', 'Diskon Faktur');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (579, 'qty', 'Qty', 'Qty');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (580, 'discounts', 'Discount', 'Diskon');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (581, 'sub_total', 'Sub Total', 'Sub Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (582, 'paid', 'Paid', 'Berbayar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (583, 'change', 'Change', 'Perubahan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (584, 'purchase_price', 'Purchase Price', 'Harga pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (585, 'expiry', 'Expiry', 'Kedaluwarsa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (586, 'batch', 'Batch', 'Batch');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (587, 'role_permission', 'Role Permission', 'Izin Peran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (588, 'user_assign_role', 'Assign  User Role', 'Tetapkan Peran Pengguna');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (589, 'permission', 'Permission', 'Izin');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (590, 'personal_loan', 'Personal Loan', 'Pinjaman Pribadi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (591, 'role_name', 'Role Name', 'Nama peran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (592, 'create', 'Create', 'Membuat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (593, 'read', 'Read', 'Baca');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (594, 'add_role', 'Add Role', 'Tambahkan Peran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (595, 'You do not have permission to access. Please contact with administrator.', 'You do not have permission to access. Please contact with administrator.', 'Anda tidak memiliki izin untuk mengakses. Silakan kontak dengan administrator. ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (596, 'role_permission_added_successfully', 'Role Permission Added successfully.', 'Izin Peran berhasil ditambahkan.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (597, 'role_list', 'Role List', 'Daftar Peran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (598, 'role_permission_updated_successfully', 'Role Permission Updated Successfully.', 'Izin Peran Berhasil Diperbarui.');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (599, 'add_phrase', 'Add Phrase', 'Tambahkan Frasa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (600, 'language_home', 'Language Home', 'Beranda Bahasa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (601, 'phrase_edit', 'Phrase Edit', 'Edit Frasa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (602, 'no_role_selected', 'No Role Selected', 'Tidak Ada Peran yang Dipilih');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (603, 'category_added_successfully', 'Category added successfully', 'Kategori berhasil ditambahkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (604, 'category_already_exist', 'Category already exist', 'Kategori sudah ada');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (605, 'select_manufacturer', 'Select Manufacturer', 'Pilih Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (607, 'select_tax', 'Select Tax', 'Pilih Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (608, 'must_input_numbers', 'Must input numbers', 'Harus memasukkan angka');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (609, 'please_check_your_price', 'Please Check Your Price', 'Silakan Periksa Harga Anda');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (610, 'your_profit_is', 'Your Profit is', 'Keuntungan Anda adalah');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (611, 'failed', 'Failed', 'Gagal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (612, 'you_have_reached_the_limit_of_adding', 'You have reached the limit of adding', 'Anda telah mencapai batas penambahan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (613, 'inputs', 'inputs', 'masukan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (614, 'expiry_date_should_be_greater_than_puchase_date', 'Expiry Date should be greater than Puchase Date', 'Tanggal Kedaluwarsa harus lebih besar dari Tanggal Puchase');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (615, 'expiry_date_should_be_greater_than_puchase_date', 'Expiry Date should be greater than Puchase Date', 'Tanggal Kedaluwarsa harus lebih besar dari Tanggal Puchase');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (616, 'product_name', 'Medicine Name', 'Nama Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (617, 'total_quantity', 'Total Quantity', 'Jumlah total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (618, 'rates', 'Rate', 'Menilai');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (619, 'total_amount', 'Total Amount', 'Jumlah total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (621, 'receipt_detail', 'Receipt Detail', 'Detail Tanda Terima');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (622, 'amount', 'Amount', 'Jumlah');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (623, 'save_and_add_another_one', 'Save and add another one', 'Simpan dan tambahkan satu sama lain');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (624, 'checque_number', 'Checque Number', 'Nomor Checque');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (625, 'edit_receipt', 'Edit Receipt', 'Edit Tanda Terima');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (626, 'receipt_list', 'Receipt List', 'Daftar Tanda Terima');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (627, 'search_by_customer_name', 'Search By Customer Name', 'Cari Berdasarkan Nama Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (628, 'actions', 'Actions', 'Tindakan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (629, 'no_data_found', 'No Data Found', 'Tidak ada data ditemukan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (630, 'edit', 'Edit', 'Edit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (631, 'product_not_found', 'Medicine  not found', 'Obat tidak ditemukan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (632, 'request_failed_please_check_your_code_and_try_again', 'Request Failed, Please check your code and try again', 'Permintaan Gagal, Harap periksa kode Anda dan coba lagi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (633, 'You_can_not_return_more_than_sold_quantity', 'You Can Not Return More than Sold quantity', 'Anda Tidak Dapat Mengembalikan Lebih dari jumlah Terjual');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (634, 'you_can_not_return_less_than_1', 'You Can Not Return Less than 1', 'Anda Tidak Dapat Mengembalikan Kurang dari 1');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (635, 'transection_details', 'Transection Details', 'Detail Transeksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (636, 'transection_details_datewise', 'Transection  Details Datewise', 'Data Detail Transeksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (637, 'transection_id', 'Transactions ID', 'Transactions ID');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (638, 'select_option', 'Select Option', 'Pilih opsi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (639, 'loan_list', 'Loan List', 'Daftar pinjaman');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (640, 'todays_details', 'Todays Details', 'Detail Hari Ini');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (641, 'transaction_details', 'Transaction Details', 'Detil transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (642, 'person_id', 'Person ID', 'ID Orang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (643, 'total_transection', 'Total Transection', 'Total Transeksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (644, 'transaction_id', 'Transaction ID', 'ID transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (645, 'transection_report', 'Transection Report', 'Laporan Transeksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (646, 'add_transection', 'Add Transection', 'Tambahkan Transeksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (647, 'manage_transection', 'Manage Transection', 'Kelola Transeksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (648, 'select_id', 'Select ID', 'Pilih ID');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (649, 'choose_transection', 'Choose Transection', 'Pilih Transeksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (650, 'update_transection', 'Update Transection', 'Perbarui Transeksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (651, 'manufacturer_all', 'Manufacturer All', 'Pabrikan Semua');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (652, 'select_all', 'Select All', 'Pilih Semua');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (653, 'all', 'All', 'Semua');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (654, 'max_rate', 'Max Rate', 'Tingkat Maks');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (655, 'min_rate', 'Min Rate', 'Tingkat Min');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (656, 'average_rate', 'Average Rate', 'Harga rata-rata');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (657, 'date_expired_please_choose_another.', 'Date Expired!! Please Choose another', 'Tanggal Kedaluwarsa !! Silakan Pilih yang lain ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (658, 'your_medicine_is_date_expiry_Please_choose_another', 'Your Medicine is Date Expiry !! Please Choose another', 'Obat Anda Tanggal Kedaluwarsa !! Silakan Pilih yang lain ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (659, 'meno', 'MEMO', 'MEMO');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (660, 'out_of_stock_and_date_expired_medicine', 'Out of Stock and Date Expired Medicine', 'Obat Habis dan Tanggal Kadaluarsa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (661, 'edit_profile', 'Edit Profile', 'Sunting profil');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (662, 'deposit_detail', 'Deposit detail', 'Detail deposit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (663, 'new_deposit', 'New Deposit', 'Deposit Baru');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (664, 'edit_deposit', 'Edit Deposit', 'Edit Deposit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (665, 'select_customer', 'Select Customer', 'Pilih Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (666, 'draw', 'Draw', 'Seri');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (667, 'deposit', 'Deposit', 'Menyetorkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (668, 'select_type', 'Select Type', 'Pilih tipe');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (669, 'transaction_type', 'Transaction Type', 'Tipe transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (670, 'cash', 'Cash', 'Tunai');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (671, 'select_bank', 'Select Bank', 'Pilih Bank');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (672, 'drawing', 'Drawing', 'Gambar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (673, 'expenses', 'Expenses', 'Beban');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (674, 'banking', 'Banking', 'Perbankan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (675, 'daily_closing', 'Daily Closing', 'Penutupan Harian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (676, 'title', 'Title', 'Judul');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (677, 'error_get_data_from_ajax', 'Error get data from ajax', 'Kesalahan mendapatkan data dari ajax');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (678, 'toggle_navigation', 'Toggle Navigation', 'Toggle Navigation');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (679, 'this_product_not_found', 'This Medicine  Not Found !', 'Obat Ini Tidak Ditemukan!');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (680, 'search_by_date_from', 'Search By Date: From', 'Cari Berdasarkan Tanggal: Dari');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (681, 'manufacturer_sales_report', 'Manufacturer Sales Report', 'Laporan Penjualan Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (682, 'transection', 'Transection', 'Penampang lintang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (683, 'transection_mood', 'Transection Mood', 'Suasana Transeksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (684, 'transection_categry', 'Transection Categry', 'Kategori Transeksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (685, 'export_csv', 'Export CSV', 'Ekspor CSV');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (686, 'select manufacturer', 'Select Manufacturer', 'Select Manufacturer ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (687, 'customer_return', 'Customer Return', 'Pengembalian Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (688, 'return_form', 'Return Form', 'Formulir Pengembalian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (689, 'data_not_found', 'Data Not Found', 'Data Tidak Ditemukan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (690, 'export_csv', 'Export CSV', 'Ekspor CSV');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (691, 'manage_person', 'Manage Person', 'Kelola Orang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (692, 'backup', 'Back Up', 'Back Up');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (693, 'total_balance', 'Total Balance', 'Saldo Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (694, 'product_id_model_manufacturer_id_can_not_null', 'Medicine Id & Medicine Type & Manufacturer Id Can not be Blank', 'Id Obat & Jenis Obat & Id Produsen Tidak Bisa Kosong');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (695, 'product_name_can_not_be_null', 'Medicine  Name can Not be Blank', 'Nama Obat Tidak Bisa Kosong');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (696, 'product_model_can_not_be_null', 'Medicine  Model Can Not be Blank', 'Model Obat Tidak Bisa Kosong');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (697, 'sms', 'SMS', 'SMS');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (698, 'sms_configure', 'Sms Configuration', 'Konfigurasi Sms');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (699, 'url', 'Url', 'Url');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (700, 'sender_id', 'Sender ID', 'ID pengirim');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (701, 'api_key', 'Api Key', 'Kunci API');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (702, 'barcode_or_qrcode', 'Barcode Or QRcode ', 'Barcode atau QRcode');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (703, 'currency_name', 'Currency Name', 'Nama Mata Uang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (704, 'add_currency', 'Add Currency', 'Tambahkan Mata Uang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (705, 'currency_icon', 'Currency Icon', 'Ikon Mata Uang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (706, 'currency_list', 'Currency List', 'Daftar Mata Uang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (707, 'import', 'Import', 'Impor');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (708, 'c_o_a', 'Chart Of Account', 'Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (709, 'supplier_payment', 'Supplier Payment', 'Pembayaran Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (710, 'customer_receive', 'Customer Receive', 'Pelanggan Menerima');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (711, 'debit_voucher', 'Debit Voucher', 'Voucher Debit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (712, 'credit_voucher', 'Credit voucher', 'Voucher kredit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (713, 'voucher_approval', 'Voucher Approval', 'Persetujuan Voucher');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (714, 'contra_voucher', 'Contra Voucher', 'Contra Voucher');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (715, 'journal_voucher', 'Journal Voucher', 'Voucher Jurnal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (716, 'voucher_report', 'Voucher Report', 'Laporan Voucher');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (717, 'cash_book', 'Cash Book', 'Buku Tunai');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (718, 'inventory_ledger', 'Inventory Ledger', 'Buku Besar Inventaris');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (719, 'bank_book', 'Bank Book', 'Buku bank');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (720, 'general_ledger', 'General Ledger', 'Jurnal umum');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (721, 'trial_balance', 'Trial Balance', 'Neraca saldo');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (722, 'profit_loss_report', 'Profit Loss Report', 'Laporan Rugi Laba');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (723, 'cash_flow', 'Cash Flow', 'Arus kas');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (724, 'coa_print', 'COA Print', 'Cetak COA');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (725, 'manufacturer_payment', 'Manufacturer Payment', 'Pembayaran Produsen');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (726, 'add_more', 'Add More', 'Tambahkan Lebih Banyak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (727, 'code', 'Code', 'Kode');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (728, 'remark', 'Transaction Details', 'Detil transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (729, 'voucher_no', 'Voucher NO', 'Voucher TIDAK');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (730, 'accounts_tree_view', 'Accounts Tree view', 'Tampilan Pohon Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (731, 'find', 'Find', 'Temukan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (732, 'voucher_type', 'Voucher Type', 'Jenis Voucher');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (733, 'particulars', 'Particulars', 'Detail');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (734, 'cash_flow_statement', 'Cash Flow Statement', 'Laporan arus kas');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (735, 'amount_in_dollar', 'Amount In Dollar', 'Jumlah Dalam Dolar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (736, 'opening_cash_and_equivalent', 'Opening Cash and Equivalent', 'Membuka Uang Tunai dan Setara');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (737, 'with_details', 'With Details', 'Dengan rincian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (738, 'transaction_head', 'Transaction Head', 'Kepala Transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (739, 'gl_head', 'General Ledger Head', 'Kepala Buku Besar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (740, 'no_report', 'No Report', 'Tidak Ada Laporan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (741, 'pre_balance', 'Pre Balance', 'Pra Saldo');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (742, 'current_balance', 'Current Balance', 'Saldo saat ini');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (743, 'from_date', 'From Date', 'Dari tanggal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (744, 'to_date', 'To Date', 'Sampai Tanggal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (745, 'profit_loss', 'Profit Loss Statement', 'Laporan Laba Rugi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (746, 'add_expense_item', 'Add Expense Item', 'Tambahkan Item Biaya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (747, 'manage_expense_item', 'Manage Expense Item', 'Kelola Item Pengeluaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (748, 'add_expense', 'Add Expense', 'Tambah Biaya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (749, 'manage_expense', 'Manage Expense', 'Kelola Pengeluaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (750, 'expense_statement', 'Expense Statement', 'Pernyataan Biaya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (751, 'expense_type', 'Expense Type', 'Jenis Pengeluaran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (752, 'expense_item_name', 'Expense Item Name', 'Nama Item Biaya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (753, 'opening_balance', 'Opening Balance', 'Saldo awal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (754, 'tax_settings', 'Tax Settings', 'Pengaturan Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (755, 'add_incometax', 'Add Income Tax', 'Tambahkan Pajak Pendapatan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (756, 'manage_income_tax', 'Manage Income tax', 'Kelola pajak penghasilan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (757, 'tax_report', 'Tax Report', 'Laporan Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (758, 'invoice_wise_tax_report', 'Invoice Wise Tax Report', 'Invoice Wise Tax Report');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (759, 'number_of_tax', 'Number of Tax', 'Jumlah Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (760, 'default_value', 'Default Value', 'Nilai Default');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (761, 'reg_no', 'Registration No', 'No Registrasi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (762, 'tax_name', 'Tax Name', 'Nama Pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (763, 'service_id', 'Service Id', 'Id Layanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (764, 'service', 'Service', 'Layanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (765, 'add_service', 'Add Service', 'Tambahkan Layanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (766, 'manage_service', 'Manage Service', 'Kelola Layanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (767, 'service_invoice', 'Service Invoice', 'Faktur Layanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (768, 'manage_service_invoice', 'Manage Service Invoice', 'Kelola Faktur Layanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (769, 'service_name', 'Service Name', 'Nama layanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (770, 'charge', 'Charge', 'Biaya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (771, 'add', 'Add', 'Menambahkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (772, 'previous', 'Previous', 'Sebelumnya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (773, 'net_total', 'Net Total', 'Total Bersih');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (774, 'hanging_over', 'Estimated Time Of Departure', 'Perkiraan Waktu Keberangkatan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (775, 'service_discount', 'Service Discount', 'Diskon Layanan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (776, 'hrm', 'HRM', 'HRM');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (777, 'add_designation', 'Add Designation', 'Tambahkan Penunjukan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (778, 'manage_designation', 'Manage Designation', 'Kelola Penunjukan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (779, 'add_employee', 'Add Employee', 'Tambah Karyawan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (780, 'manage_employee', 'Manage Employee', 'Kelola Karyawan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (781, 'attendance', 'Attendance', 'Kehadiran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (782, 'add_attendance', 'Add Attendance', 'Tambah Kehadiran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (783, 'manage_attendance', 'Manage Attendance', 'Kelola Kehadiran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (784, 'attendance_report', 'Attendance Report', 'Laporan kehadiran');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (785, 'payroll', 'Payroll', 'Daftar gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (786, 'add_benefits', 'Add Benefits', 'Tambah Manfaat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (787, 'manage_benefits', 'Manage Benefits', 'Kelola Manfaat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (788, 'add_salary_setup', 'Add Salary Setup', 'Tambahkan Pengaturan Gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (789, 'manage_salary_setup', 'Manage Salary Setup', 'Kelola Pengaturan Gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (790, 'salary_generate', 'Salary Generate', 'Gaji Hasilkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (791, 'manage_salary_generate', 'Manage Salary Generate', 'Kelola Gaji Hasilkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (792, 'salary_payment', 'Salary Payment', 'Pembayaran Gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (793, 'designation', 'Designation', 'Penunjukan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (794, 'rate_type', 'Rate Type', 'Jenis Tarif');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (795, 'hour_rate_or_salary', 'Hourly Rate/Salary', 'Tarif / Gaji Per Jam');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (796, 'blood_group', 'Blood Group', 'Golongan darah');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (797, 'address_line_1', 'Address Line 1', 'Baris Alamat 1');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (798, 'address_line_2', 'Address Line 2', 'Alamat Baris 2');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (799, 'picture', 'Picture', 'Gambar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (800, 'country', 'Country', 'Negara');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (801, 'city', 'City', 'Kota');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (802, 'zip', 'Zip code', 'Kode Pos');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (803, 'single_checkin', 'Single Check In', 'Single Check In');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (804, 'bulk_checkin', 'Bulk Check In', 'Check In Massal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (805, 'checkin', 'Check In', 'Mendaftar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (806, 'employee_name', 'Employee Name', 'Nama karyawan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (807, 'check_in', 'Check In', 'Mendaftar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (808, 'checkout', 'Check Out', 'Periksa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (809, 'confirm_clock', 'Confirm Clock', 'Konfirmasi Jam');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (810, 'stay', 'Stay', 'Tinggal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (811, 'download_sample_file', 'Download Sample File', 'Unduh File Contoh');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (812, 'employee', 'Employee', 'Karyawan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (813, 'sign_in', 'Check In', 'Mendaftar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (814, 'sign_out', 'Check  Out', 'Periksa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (815, 'staytime', 'Stay Time', 'Tetap Waktu');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (816, 'benefits_list', 'Benefit List', 'Daftar Manfaat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (817, 'benefits', 'Benefits', 'Manfaat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (818, 'benefit_type', 'Benefit Type', 'Jenis Manfaat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (819, 'salary_benefits', 'Salary Benefits', 'Manfaat Gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (820, 'salary_benefits_type', 'Salary Benefits Type', 'Jenis Manfaat Gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (821, 'hourly', 'Hourly', 'Per jam');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (822, 'salary', 'Salary', 'Gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (823, 'timezone', 'Time Zone', 'Zona waktu');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (824, 'request', 'Request', 'Permintaan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (825, 'datewise_report', 'Date Wise Report', 'Date Wise Report');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (826, 'work_hour', 'Work Hours', 'Jam kerja');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (827, 'employee_wise_report', 'Employee Wise Report', 'Laporan Bijaksana Karyawan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (828, 'date_in_time_report', 'In Time Report', 'In Time Report');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (829, 'successfully_checkout', 'Successfully Checked Out', 'Berhasil Diperiksa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (830, 'setup_tax', 'Setup Tax', 'Setup Tax');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (831, 'start_amount', 'Start Amount', 'Jumlah Awal');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (832, 'end_amount', 'End Amount', 'Jumlah Akhir');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (833, 'tax_rate', 'Tax Rate', 'Persentase pajak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (834, 'setup', 'Setup', 'Mendirikan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (835, 'income_tax_updateform', 'Income Tax Update Form', 'Formulir Pembaruan Pajak Pendapatan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (836, 'salary_type', 'Salary Type', 'Jenis Gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (837, 'addition', 'Addition', 'Tambahan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (838, 'gross_salary', 'Gross Salary', 'Gaji kotor');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (839, 'set', 'Set', 'Set');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (840, 'salary_month', 'Salary Month', 'Bulan Gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (841, 'generate', 'Generate ', 'Hasilkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (842, 'total_salary', 'Total Salary', 'Gaji Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (843, 'total_working_minutes', 'Total Working Hours', 'Total Jam Kerja');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (844, 'working_period', 'Total Working Days', 'Total Hari Kerja');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (845, 'paid_by', 'Paid By', 'Dibayar oleh');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (846, 'pay_now', 'Pay Now ?', 'Bayar sekarang ?');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (847, 'confirm', 'Confirm', 'Konfirmasi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (848, 'generate_by', 'Generate By', 'Hasilkan Oleh');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (849, 'gui_pos', 'GUI POS', 'GUI POS');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (850, 'add_fixed_assets', 'Add Fixed Assets', 'Tambah Aset Tetap');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (851, 'fixed_assets_list', 'Fixed Asset List', 'Daftar Aset Tetap');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (852, 'fixed_assets_purchase', 'Purchase Fixed Assets', 'Beli Aset Tetap');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (853, 'fixed_assets_purchase_manage', 'Fixed Assets Purchase List', 'Daftar Pembelian Aset Tetap');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (854, 'fixed_assets', 'Fixed Assets', 'Aset Tetap');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (855, 'item_code', 'Item code', 'Kode barang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (856, 'item_name', 'Item Name', 'Nama barang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (857, 'opening_assets', 'Assets Qty', 'Jumlah Aset');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (858, 'edit_fixed_asset', 'Edit Fixed Assets', 'Edit Aset Tetap');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (859, 'save_change', 'Save Change', 'Simpan perubahan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (860, 'in_word', 'In Word', 'Dalam Kata');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (861, 'purchase_pad_print', 'Purchase Pad Print', 'Beli Cetak Pad');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (862, 'fixed_assets_purchase_details', 'Fixed Assets Purchase Details', 'Rincian Pembelian Aset Tetap');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (863, 'manage_language', 'Manage Language', 'Kelola Bahasa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (864, 'person_edit', 'Person Edit', 'Sunting Orang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (865, 'person_ledger', 'Person Ledger', 'Buku Besar Orang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (866, 'medicine_name', 'Medicine Name', 'Nama Obat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (867, 'unit_list', 'Unit List', 'Daftar Unit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (868, 'add_unit', 'Add Unit', 'Tambahkan Unit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (869, 'edit_unit', 'Edit Unit', 'Edit Unit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (870, 'unit_name', 'Unit Name', 'Nama unit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (871, 'unit_not_selected', 'Unit did not Selected', 'Unit tidak Dipilih');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (872, 'supplier', 'Supplier', 'Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (873, 'add_supplier', 'Add Supplier', 'Tambahkan Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (874, 'manage_supplier', 'Manage Supplier', 'Kelola Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (875, 'supplier_ledger', 'Supplier Ledger', 'Buku Besar Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (876, 'supplier_sales_details', 'Supplier Sales Details', 'Detail Penjualan Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (877, 'purchase_detail', 'Purchase details', 'Rincian pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (878, 'purchase_information', 'Purchase Information', 'Informasi pembelian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (879, 'account_head', 'Account Head', 'Kepala Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (880, 'transaction_date', 'Transaction Date', 'Tanggal transaksi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (881, 'approved', 'Approve', 'Menyetujui');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (882, 'date_wise_report', 'Date Wise Report', 'Date Wise Report');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (883, 'time_wise_report', 'Time Wise Report', 'Time Wise Report');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (884, 'report_date', 'Report Date', 'Tanggal Laporan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (885, 's_time', 'Start Time', 'Waktu mulai');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (886, 'e_time', 'End Time', 'Akhir waktu');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (887, 'basic', 'Basic', 'Dasar');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (888, 'supplier_name', 'Supplier Name', 'Nama pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (889, 'supplier_mobile', 'Supplier Mobile', 'Seluler Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (890, 'supplier_address', 'Supplier Address', 'Alamat Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (891, 'supplier_details', 'Supplier Details', 'Detail Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (892, 'select_supplier', 'Select Supplier', 'Pilih Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (893, 'accounts_report', 'Accounts Report', 'Laporan Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (894, 'account_code', 'Account Code', 'Kode akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (895, 'human_resource_management', 'Human Resource ', 'Sumber daya manusia ');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (896, 'menu_name', 'Menu Name', 'Nama Menu');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (897, 'head_of_account', 'Account Head', 'Kepala Akun');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (898, 'successfully_approved', 'Successfully Approved', 'Berhasil Disetujui');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (899, 'supplier_edit', 'Supplier Edit', 'Pemasok Edit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (900, 'supplier_id', 'Supplier ID', 'ID Pemasok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (901, 'strength', 'Strength', 'Kekuatan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (902, 'out_of_date', 'Out Of Date', 'Kadaluarsa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (903, 'dis', 'Dis', 'Dis');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (904, 'date_expired_please_choose_another', 'Date Expire Please Choose another', 'Tanggal Kedaluwarsa Silakan Pilih yang lain');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (905, 'expired', 'Expired', 'Kedaluwarsa');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (906, 'cash_adjustment', 'Cash Adjustment', 'Penyesuaian Uang Tunai');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (907, 'adjustment_type', 'Adjustment Type', 'Jenis Penyesuaian');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (908, 'cash_payment', 'Cash Payment', 'Pembayaran tunai');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (909, 'bank_payment', 'Bank Payment', 'Pembayaran Bank');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (910, 'yes', 'Yes', 'Iya');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (911, 'no', 'No', 'Tidak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (912, 'credit_account_head', 'Credit Account Head', 'Kepala Akun Kredit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (913, 'general_ledger_of', 'General Ledger Of', 'Buku Besar Dari');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (914, 'debit_account_head', 'Debit Account Head', 'Kepala Akun Debit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (915, 'update_successfully', 'Successfully Updated', 'Berhasil diperbarui');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (916, 'statement_of_comprehensive_income', 'Statement of Comprehensive Income', 'Laporan Pendapatan Komprehensif');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (917, 'deduct', 'Deduct', 'Mengurangi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (918, 'payslip', 'Payslip', 'Payslip');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (919, 'salary_slip', 'Salary Slip', 'Slip gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (920, 'salary_date', 'Salary Date', 'Tanggal Gaji');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (921, 'earnings', 'Earnings', 'Pendapatan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (922, 'basic_salary', 'Basic Salary', 'Gaji pokok');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (923, 'total_addition', 'Total Addition', 'Penambahan Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (924, 'total_deduction', 'Total Deduction', 'Potongan Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (925, 'net_salary', 'Net Salary', 'Gaji bersih');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (926, 'ref_number', 'Reference No', 'Nomor referensi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (927, 'employee_signature', 'Employee Signature', 'Tanda tangan karyawan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (928, 'authorized_signature', 'Authorized Signature', 'Tanda tangan resmi');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (929, 'chairman', 'Chairman', 'Ketua');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (930, 'bank_ledger', 'Bank Ledger', 'Buku Besar Bank');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (931, 'api_secret', 'Api Secret', 'Api Rahasia');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (932, 'service_csv_upload', 'Service Csv Upload', 'Layanan Csv Upload');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (933, 'shipping_cost', 'Shipping Cost', 'Biaya pengiriman');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (934, 'customer_advance', 'Customer Advance', 'Customer Advance');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (935, 'customer_csv_upload', 'Customer CSV Upload', 'Unggahan CSV Pelanggan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (936, 'contact', 'Contact', 'Kontak');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (937, 'fax', 'Fax', 'Fax');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (938, 'state', 'State', 'Negara');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (939, 'address1', 'Address1', 'Alamat 1');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (940, 'address2', 'Address2', 'Alamat 2');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (941, 'manufacturer_advance', 'Manufacturer Advance', 'Produsen Maju');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (942, 'csv_upload_manufacturer', 'CSV Upload Manufacturer', 'Produsen Unggahan CSV');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (943, 'restore', 'Restore ', 'Pulihkan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (944, 'advance_type', 'Advance Type', 'Jenis Lanjut');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (945, 'receive', 'Receive', 'Menerima');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (946, 'note_name', 'Notes', 'Catatan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (947, 'pcs', 'PCS', 'PCS');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (948, 'do_you_want_to_print', 'Do You Want To Print ?', 'Apakah Anda Ingin Mencetak?');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (949, 'the_salary_of', NULL, NULL);
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (950, 'already_generated', 'Already Generated', 'Sudah Dibuat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (951, 'successfully_generated', 'Successfully Generated', 'Berhasil Dibuat');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (952, 'service_edit', 'Service Edit', 'Layanan Edit');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (953, 'signature', 'Signature', 'Tanda tangan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (954, 'manage', 'Manage', 'Mengelola');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (955, 'income_expense_statement', 'Income Expense Statement', 'Laporan Beban Penghasilan');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (956, 'cash_received', 'Cash Received', 'Uang diterima');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (957, 'bank_received', 'Bank Received', 'Bank Diterima');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (958, 'total_due', 'Total Due', 'Total Hutang');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (959, 'total_service', 'Total Service', 'Layanan Total');
INSERT INTO `language` (`id`, `phrase`, `english`, `bahasa`) VALUES (960, 'type_not_selected', 'Type did not Selected', 'Jenis tidak Dipilih');


#
# TABLE STRUCTURE FOR: manufacturer_information
#

DROP TABLE IF EXISTS `manufacturer_information`;

CREATE TABLE `manufacturer_information` (
  `manufacturer_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `manufacturer_name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address2` text DEFAULT NULL,
  `mobile` varchar(100) DEFAULT NULL,
  `emailnumber` varchar(200) DEFAULT NULL,
  `email_address` varchar(200) DEFAULT NULL,
  `contact` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `fax` varchar(100) DEFAULT NULL,
  `city` text DEFAULT NULL,
  `state` text DEFAULT NULL,
  `zip` varchar(50) DEFAULT NULL,
  `country` varchar(250) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `status` int(2) DEFAULT NULL,
  PRIMARY KEY (`manufacturer_id`),
  KEY `manufacturer_id` (`manufacturer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: module
#

DROP TABLE IF EXISTS `module`;

CREATE TABLE `module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `directory` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (1, 'Invoice', '', '', 'invoice', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (2, 'Customer', '', '', 'customer', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (3, 'Medicine', '', '', 'medicine', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (4, 'Manufacturer', '', '', 'manufacturer', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (5, 'Purchase', '', '', 'purchase', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (6, 'Stock', '', '', 'stock', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (7, 'Return', '', '', 'return', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (8, 'Report', '', '', 'report', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (9, 'Accounts', '', '', 'accounts', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (10, 'Bank', '', '', 'bank', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (11, 'Tax', '', '', 'tax', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (12, 'Human Resource', '', '', 'human_resource_info', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (13, 'Supplier', '', '', 'supplier', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (14, 'Service', '', '', 'service', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (15, 'Search', '', '', 'search', 1);
INSERT INTO `module` (`id`, `name`, `description`, `image`, `directory`, `status`) VALUES (16, 'Settings', '', '', 'settings', 1);


#
# TABLE STRUCTURE FOR: payroll_tax_setup
#

DROP TABLE IF EXISTS `payroll_tax_setup`;

CREATE TABLE `payroll_tax_setup` (
  `tax_setup_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `start_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `end_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `rate` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tax_setup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: person_information
#

DROP TABLE IF EXISTS `person_information`;

CREATE TABLE `person_information` (
  `person_id` varchar(50) NOT NULL,
  `person_name` varchar(50) NOT NULL,
  `person_phone` varchar(50) NOT NULL,
  `person_address` text NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: person_ledger
#

DROP TABLE IF EXISTS `person_ledger`;

CREATE TABLE `person_ledger` (
  `transaction_id` varchar(50) NOT NULL,
  `person_id` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  `debit` decimal(12,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(10,2) NOT NULL DEFAULT 0.00,
  `details` text NOT NULL,
  `status` int(11) NOT NULL COMMENT '1=no paid,2=paid',
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: personal_loan
#

DROP TABLE IF EXISTS `personal_loan`;

CREATE TABLE `personal_loan` (
  `per_loan_id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(30) NOT NULL,
  `person_id` varchar(30) NOT NULL,
  `debit` varchar(20) NOT NULL,
  `credit` float NOT NULL,
  `date` varchar(30) NOT NULL,
  `details` varchar(100) NOT NULL,
  `status` int(11) NOT NULL COMMENT '1=no paid,2=paid',
  PRIMARY KEY (`per_loan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: pesonal_loan_information
#

DROP TABLE IF EXISTS `pesonal_loan_information`;

CREATE TABLE `pesonal_loan_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` varchar(50) NOT NULL,
  `person_name` varchar(50) NOT NULL,
  `person_phone` varchar(30) NOT NULL,
  `person_address` text NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: product_category
#

DROP TABLE IF EXISTS `product_category`;

CREATE TABLE `product_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: product_information
#

DROP TABLE IF EXISTS `product_information`;

CREATE TABLE `product_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` varchar(30) NOT NULL,
  `category_id` varchar(50) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `generic_name` varchar(250) NOT NULL,
  `strength` varchar(250) NOT NULL,
  `box_size` varchar(30) NOT NULL,
  `product_location` varchar(50) NOT NULL,
  `price` varchar(20) NOT NULL,
  `tax` varchar(20) DEFAULT NULL,
  `product_model` varchar(50) DEFAULT NULL,
  `manufacturer_id` bigint(20) NOT NULL,
  `manufacturer_price` decimal(10,2) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `product_details` varchar(250) DEFAULT NULL,
  `image` text NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `manufacturer_id` (`manufacturer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

#
# TABLE STRUCTURE FOR: product_purchase
#

DROP TABLE IF EXISTS `product_purchase`;

CREATE TABLE `product_purchase` (
  `chalan_no` varchar(100) NOT NULL,
  `manufacturer_id` varchar(100) NOT NULL,
  `grand_total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_discount` decimal(10,2) DEFAULT 0.00,
  `purchase_date` varchar(50) NOT NULL,
  `purchase_details` text NOT NULL,
  `status` int(2) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` varchar(30) NOT NULL,
  `bank_id` varchar(30) DEFAULT NULL,
  `payment_type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `manufacturer_id` (`manufacturer_id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `bank_id` (`bank_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: product_purchase_details
#

DROP TABLE IF EXISTS `product_purchase_details`;

CREATE TABLE `product_purchase_details` (
  `purchase_detail_id` varchar(100) NOT NULL,
  `purchase_id` varchar(100) NOT NULL,
  `product_id` varchar(100) NOT NULL,
  `quantity` decimal(12,2) NOT NULL DEFAULT 0.00,
  `rate` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(10,2) DEFAULT 0.00,
  `batch_id` varchar(25) NOT NULL,
  `expeire_date` varchar(30) NOT NULL,
  `status` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `purchase_id` (`purchase_id`),
  KEY `product_id` (`product_id`),
  KEY `batch_id` (`batch_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: product_return
#

DROP TABLE IF EXISTS `product_return`;

CREATE TABLE `product_return` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `return_id` varchar(30) NOT NULL,
  `product_id` varchar(20) NOT NULL,
  `invoice_id` varchar(20) NOT NULL,
  `purchase_id` varchar(30) DEFAULT NULL,
  `date_purchase` varchar(20) NOT NULL,
  `date_return` varchar(30) NOT NULL,
  `byy_qty` decimal(12,2) NOT NULL DEFAULT 0.00,
  `ret_qty` decimal(10,2) NOT NULL DEFAULT 0.00,
  `customer_id` varchar(20) NOT NULL,
  `manufacturer_id` varchar(30) NOT NULL,
  `product_rate` decimal(12,2) NOT NULL DEFAULT 0.00,
  `deduction` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_deduct` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_tax` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total_ret_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `net_total_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `reason` text NOT NULL,
  `usablity` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

#
# TABLE STRUCTURE FOR: product_service
#

DROP TABLE IF EXISTS `product_service`;

CREATE TABLE `product_service` (
  `service_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_name` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `charge` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: product_type
#

DROP TABLE IF EXISTS `product_type`;

CREATE TABLE `product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` varchar(255) DEFAULT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: role_permission
#

DROP TABLE IF EXISTS `role_permission`;

CREATE TABLE `role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_module_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `create` tinyint(1) DEFAULT NULL,
  `read` tinyint(1) DEFAULT NULL,
  `update` tinyint(1) DEFAULT NULL,
  `delete` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_module_id` (`fk_module_id`),
  KEY `fk_user_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: salary_sheet_generate
#

DROP TABLE IF EXISTS `salary_sheet_generate`;

CREATE TABLE `salary_sheet_generate` (
  `ssg_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `gdate` varchar(30) DEFAULT NULL,
  `start_date` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `end_date` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `generate_by` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`ssg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: salary_type
#

DROP TABLE IF EXISTS `salary_type`;

CREATE TABLE `salary_type` (
  `salary_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `sal_name` varchar(100) NOT NULL,
  `salary_type` varchar(50) NOT NULL,
  `status` varchar(30) NOT NULL,
  PRIMARY KEY (`salary_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: sec_role
#

DROP TABLE IF EXISTS `sec_role`;

CREATE TABLE `sec_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

#
# TABLE STRUCTURE FOR: sec_userrole
#

DROP TABLE IF EXISTS `sec_userrole`;

CREATE TABLE `sec_userrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `roleid` int(11) NOT NULL,
  `createby` varchar(50) NOT NULL,
  `createdate` datetime DEFAULT NULL,
  UNIQUE KEY `ID` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

#
# TABLE STRUCTURE FOR: service_invoice
#

DROP TABLE IF EXISTS `service_invoice`;

CREATE TABLE `service_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `voucher_no` varchar(30) NOT NULL,
  `date` date NOT NULL,
  `employee_id` varchar(50) NOT NULL,
  `customer_id` varchar(30) NOT NULL,
  `total_amount` decimal(20,2) NOT NULL DEFAULT 0.00,
  `total_discount` decimal(20,2) NOT NULL DEFAULT 0.00,
  `invoice_discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_tax` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `due_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `shipping_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `previous` decimal(10,2) NOT NULL DEFAULT 0.00,
  `details` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employee_id` (`employee_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: service_invoice_details
#

DROP TABLE IF EXISTS `service_invoice_details`;

CREATE TABLE `service_invoice_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `service_id` int(11) NOT NULL,
  `service_inv_id` varchar(30) NOT NULL,
  `qty` decimal(10,2) NOT NULL DEFAULT 0.00,
  `charge` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `service_id` (`service_id`),
  KEY `service_inv_id` (`service_inv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: sms_settings
#

DROP TABLE IF EXISTS `sms_settings`;

CREATE TABLE `sms_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_key` varchar(100) DEFAULT NULL,
  `api_secret` varchar(100) DEFAULT NULL,
  `from` varchar(100) DEFAULT NULL,
  `isinvoice` int(11) NOT NULL DEFAULT 0,
  `ispurchase` int(11) DEFAULT 0,
  `isservice` int(11) NOT NULL DEFAULT 0,
  `isreceive` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `sms_settings` (`id`, `api_key`, `api_secret`, `from`, `isinvoice`, `ispurchase`, `isservice`, `isreceive`) VALUES (1, '60d6748a', 'NrW61s2AfTbgYkNk', 'isahaq', 0, 0, 1, 0);


#
# TABLE STRUCTURE FOR: stock_fixed_asset
#

DROP TABLE IF EXISTS `stock_fixed_asset`;

CREATE TABLE `stock_fixed_asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` int(11) NOT NULL,
  `item_code` varchar(50) NOT NULL,
  `qty` float NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: sub_module
#

DROP TABLE IF EXISTS `sub_module`;

CREATE TABLE `sub_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(100) NOT NULL,
  `directory` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (1, 1, 'New Invoice', '', '', 'new_invoice', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (2, 1, 'Manage Invoice', '', '', 'manage_invoice', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (3, 1, 'POS INVOICE', '', '', 'pos_invoice', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (4, 1, 'GUI POS', '', '', 'gui_pos', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (5, 9, 'Chart Of Account', '', '', 'show_tree', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (6, 9, 'Manufacturer Payment', '', '', 'manufacturer_payment', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (7, 9, 'Supplier Payment', '', '', 'supplier_payment', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (8, 9, 'Customer Receive', '', '', 'customer_receive', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (9, 9, 'Debit Voucher', '', '', 'debit_voucher', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (10, 9, 'Credit Voucher', '', '', 'credit_voucher', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (11, 9, 'Contra Voucher', '', '', 'contra_voucher', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (12, 9, 'Journal Voucher', '', '', 'journal_voucher', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (13, 9, 'Voucher Approval', '', '', 'aprove_v', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (14, 9, 'Report', '', '', 'ac_report', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (15, 9, 'Cash Book', '', '', 'cash_book', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (16, 9, 'Bank Book', '', '', 'bank_book', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (17, 9, 'General Ledger', '', '', 'general_ledger', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (18, 9, 'Inventory Ledger', '', '', 'Inventory_ledger', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (19, 9, 'Cash Flow', '', '', 'cash_flow_report', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (20, 9, 'Profit Loss Statement', '', '', 'profit_loss_report', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (21, 9, 'Trial Balance', '', '', 'trial_balance', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (22, 3, 'Category', '', '', 'add_category', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (23, 3, 'Medicine Type', '', '', 'medicine_type', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (24, 3, 'Add Medicine', '', '', 'add_medicine', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (25, 3, 'Import Medicine(CSV)', '', '', 'import_medicine_csv', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (26, 3, 'Manage Medicine', '', '', 'manage_medicine', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (27, 2, 'Add Customer', '', '', 'add_customer', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (28, 2, 'Manage Customer', '', '', 'manage_customer', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (29, 2, 'Credit Customer', '', '', 'credit_customer', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (30, 2, 'Paid Customer', '', '', 'paid_customer', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (31, 4, 'Add Manufacturer', '', '', 'add_manufacturer', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (32, 4, 'Manage Manufacturer', '', '', 'manage_manufacturer', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (33, 4, 'Manufacturer Ledger', '', '', 'manufacturer_ledger', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (34, 4, 'Manufacturer Sales Details', '', '', 'manufacturer_sales_details', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (35, 5, 'Add Purchase', '', '', 'add_purchase', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (36, 5, 'Manage Purchase', '', '', 'manage_purchase', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (37, 12, 'Add Designation', '', '', 'add_designation', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (38, 12, 'Manage Designation', '', '', 'manage_designation', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (39, 12, 'Add Employee', '', '', 'add_employee', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (40, 12, 'Manage Employee', '', '', 'manage_employee', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (41, 12, 'Add Attendance', '', '', 'add_attendance', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (42, 12, 'Manage Attendance', '', '', 'manage_attendance', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (43, 12, 'Attendance Report', '', '', 'attendance_report', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (44, 12, 'Add Benefits', '', '', 'add_benefits', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (45, 12, 'Manage Benefits', '', '', 'manage_benefits', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (46, 12, 'Add Salary Setup', '', '', 'add_salary_setup', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (47, 12, 'Manage Salary Setup', '', '', 'manage_salary_setup', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (48, 12, 'Salary Generate', '', '', 'salary_generate', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (49, 12, 'Manage Salary Generate', '', '', 'manage_salary_generate', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (50, 12, 'Salary Payment', '', '', 'salary_payment', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (51, 12, 'Add Expense Item', '', '', 'add_expense_item', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (52, 12, 'Manage Expense Item', '', '', 'manage_expense_item', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (53, 12, 'Add Expense', '', '', 'add_expense', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (54, 12, 'Manage Expense', '', '', 'manage_expense', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (55, 12, 'Add Fixed Assets', '', '', 'add_fixed_assets', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (56, 12, 'Fixed Asset List', '', '', 'fixed_assets_list', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (57, 12, 'Purchase Fixed Assets', '', '', 'fixed_assets_purchase', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (58, 12, 'Fixed Asset Purchase List', '', '', 'fixed_assets_purchase_manage', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (59, 16, 'Manage Company', '', '', 'manage_company', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (60, 7, 'Return', '', '', 'return', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (61, 7, 'Stock Return List', '', '', 'stock_return_list', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (62, 7, 'Manufacturer Return List', '', '', 'manufacturer_return_list', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (63, 7, 'Wastage Return List', '', '', 'wastage_return_list', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (64, 15, 'Medicine', '', '', 'medicine_search', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (65, 15, 'Customer', '', '', 'customer_search', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (66, 15, 'Invoice', '', '', 'invoice_search', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (67, 15, 'Purchase', '', '', 'purcahse_search', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (68, 14, 'Add Service', '', '', 'create_service', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (69, 14, 'Manage Service', '', '', 'manage_service', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (70, 14, 'Service Invoice', '', '', 'service_invoice', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (71, 14, 'Manage Service Invoice', '', '', 'manage_service_invoice', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (72, 11, 'Tax Settings', '', '', 'tax_settings', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (73, 11, 'Add Income Tax', '', '', 'add_incometax', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (74, 11, 'Manage Income Tax', '', '', 'manage_income_tax', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (75, 11, 'Tax Report', '', '', 'tax_report', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (76, 11, 'Invoice Wise Tax Report', '', '', 'invoice_wise_tax_report', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (77, 6, 'Stock Report', '', '', 'stock_report', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (80, 6, 'Stock Report(Batch Wise)', '', '', 'stock_report_batch_wise', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (81, 8, 'Today\'s Report', '', '', 'todays_report', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (82, 8, 'Sales Report', '', '', 'sales_report', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (83, 8, 'Purchase Report', '', '', 'purchase_report', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (84, 8, 'Sales Report(Medicine Wise)', '', '', 'sales_report_medicine_wise', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (85, 8, 'Profit/Loss', '', '', 'profit_loss', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (86, 10, 'Add New Bank', '', '', 'add_new_bank', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (87, 10, 'Bank Transaction', '', '', 'bank_transaction', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (88, 10, 'Manage Bank', '', '', 'manage_bank', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (89, 12, 'Add Person(Personal Loan)', '', '', 'office_add_person', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (90, 12, 'Manage Person(Personal Loan)', '', '', 'office_manage_loan', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (91, 12, 'Add Person(Office Loan)', '', '', 'personal_add_person', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (92, 12, 'Add Loan(Office Loan)', '', '', 'personal_add_loan', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (93, 12, 'Add Payment(Office Loan)', '', '', 'personal_add_payment', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (94, 12, 'Manage Loan(Office Loan)', '', '', 'personal_manage_loan', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (95, 16, 'Add User', '', '', 'add_user', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (96, 16, 'Manage Users', '', '', 'manage_users', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (97, 16, 'Lanaguage', '', '', 'language', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (98, 16, 'Currency', '', '', 'currency', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (99, 16, 'Web Setting', '', '', 'soft_setting', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (100, 16, 'Add Role', '', '', 'add_role', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (101, 16, 'Role List', '', '', 'role_list', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (102, 16, 'Assign User Role', '', '', 'user_assign_role', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (103, 16, 'Permission', '', '', 'permission', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (104, 16, 'SMS', '', '', 'configure_sms', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (105, 3, 'Add Unit', '', '', 'add_unit', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (106, 3, 'Unit List', '', '', 'unit_list', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (107, 13, 'Add Supplier', '', '', 'add_supplier', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (108, 13, 'Manage Supplier', '', '', 'manage_supplier', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (109, 13, 'Supplier Ledger', '', '', 'supplier_ledger', 1);
INSERT INTO `sub_module` (`id`, `mid`, `name`, `description`, `image`, `directory`, `status`) VALUES (110, 9, 'COA Print', '', '', 'coa_print', 1);


#
# TABLE STRUCTURE FOR: supplier_information
#

DROP TABLE IF EXISTS `supplier_information`;

CREATE TABLE `supplier_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` varchar(100) NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `mobile` varchar(100) NOT NULL,
  `details` varchar(255) NOT NULL,
  `status` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: supplier_ledger
#

DROP TABLE IF EXISTS `supplier_ledger`;

CREATE TABLE `supplier_ledger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(100) NOT NULL,
  `supplier_id` varchar(100) NOT NULL,
  `chalan_no` varchar(100) DEFAULT NULL,
  `deposit_no` varchar(50) DEFAULT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `description` varchar(255) NOT NULL,
  `payment_type` varchar(255) NOT NULL,
  `cheque_no` varchar(255) NOT NULL,
  `date` varchar(50) NOT NULL,
  `status` int(2) NOT NULL,
  `d_c` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: synchronizer_setting
#

DROP TABLE IF EXISTS `synchronizer_setting`;

CREATE TABLE `synchronizer_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `port` varchar(10) NOT NULL,
  `debug` varchar(10) NOT NULL,
  `project_root` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: tax_collection
#

DROP TABLE IF EXISTS `tax_collection`;

CREATE TABLE `tax_collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `customer_id` varchar(30) NOT NULL,
  `relation_id` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: tax_information
#

DROP TABLE IF EXISTS `tax_information`;

CREATE TABLE `tax_information` (
  `tax_id` varchar(15) NOT NULL,
  `tax` float DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`tax_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: tax_settings
#

DROP TABLE IF EXISTS `tax_settings`;

CREATE TABLE `tax_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `default_value` float NOT NULL,
  `tax_name` varchar(250) NOT NULL,
  `nt` int(11) NOT NULL,
  `reg_no` varchar(100) DEFAULT NULL,
  `is_show` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: unit
#

DROP TABLE IF EXISTS `unit`;

CREATE TABLE `unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(200) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

#
# TABLE STRUCTURE FOR: user_login
#

DROP TABLE IF EXISTS `user_login`;

CREATE TABLE `user_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(15) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_type` int(2) DEFAULT NULL,
  `security_code` varchar(255) DEFAULT NULL,
  `status` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `user_login` (`id`, `user_id`, `username`, `password`, `user_type`, `security_code`, `status`) VALUES (1, '2', 'admin@example.com', '41d99b369894eb1ec3f461135132d8bb', 1, NULL, 1);
INSERT INTO `user_login` (`id`, `user_id`, `username`, `password`, `user_type`, `security_code`, `status`) VALUES (2, '1', 'admin@gmail.com', '035e7767f3f2940b3a6b2817cbdbe9e6', 1, NULL, 1);


#
# TABLE STRUCTURE FOR: users
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(15) NOT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `company_name` varchar(250) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` int(2) DEFAULT NULL,
  `date_of_birth` varchar(255) DEFAULT NULL,
  `logo` varchar(250) DEFAULT NULL,
  `status` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `users` (`id`, `user_id`, `last_name`, `first_name`, `company_name`, `address`, `phone`, `gender`, `date_of_birth`, `logo`, `status`) VALUES (1, '2', 'User', 'Admin', NULL, NULL, NULL, NULL, NULL, 'http://localhost/saleserp_v9.8/assets/dist/img/profile_picture/profile.jpg', 1);
INSERT INTO `users` (`id`, `user_id`, `last_name`, `first_name`, `company_name`, `address`, `phone`, `gender`, `date_of_birth`, `logo`, `status`) VALUES (2, '1', 'User', 'Admin', NULL, NULL, NULL, NULL, NULL, 'https://apotik.fajri-hulvi.com/assets/dist/img/profile_picture/profile.jpg', 1);


#
# TABLE STRUCTURE FOR: web_setting
#

DROP TABLE IF EXISTS `web_setting`;

CREATE TABLE `web_setting` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `logo` varchar(255) DEFAULT NULL,
  `invoice_logo` varchar(255) DEFAULT NULL,
  `favicon` varchar(255) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `timezone` varchar(200) DEFAULT NULL,
  `currency_position` varchar(10) DEFAULT NULL,
  `footer_text` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `rtr` varchar(255) DEFAULT NULL,
  `captcha` int(11) DEFAULT 1 COMMENT '0=active,1=inactive',
  `site_key` varchar(250) DEFAULT NULL,
  `secret_key` varchar(250) DEFAULT NULL,
  `discount_type` int(11) DEFAULT 1,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `web_setting` (`setting_id`, `logo`, `invoice_logo`, `favicon`, `currency`, `timezone`, `currency_position`, `footer_text`, `language`, `rtr`, `captcha`, `site_key`, `secret_key`, `discount_type`) VALUES (1, 'https://fajri-hulvi.com/public/images/67302611_489862001749145_6036041684872619465_n.jpg', 'https://fajri-hulvi.com/public/images/67302611_489862001749145_6036041684872619465_n.jpg', 'https://fajri-hulvi.com/public/images/67302611_489862001749145_6036041684872619465_n.jpg', '$', 'Asia/Jakarta', '0', 'CopyrightÂ© 2022', 'bahasa', '0', 1, '', '', 1);


