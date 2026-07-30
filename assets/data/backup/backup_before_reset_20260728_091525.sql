-- MariaDB dump 10.19  Distrib 10.4.28-MariaDB, for osx10.10 (x86_64)
--
-- Host: localhost    Database: apotik_alang
-- ------------------------------------------------------
-- Server version	10.4.28-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acc_coa`
--

DROP TABLE IF EXISTS `acc_coa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_coa`
--

LOCK TABLES `acc_coa` WRITE;
/*!40000 ALTER TABLE `acc_coa` DISABLE KEYS */;
INSERT INTO `acc_coa` VALUES ('50202','Account Payable','Current Liabilities',2,1,0,1,'L',0,NULL,NULL,0,0.00,'admin','2015-10-15 19:50:43','','2019-08-10 11:01:12'),('10203','Account Receivable','Current Asset',2,1,0,0,'A',0,NULL,NULL,0,0.00,'','2019-08-10 11:01:12','admin','2013-09-18 15:29:35'),('1','Assets','COA',0,1,0,0,'A',0,NULL,NULL,0,0.00,'','2019-08-10 11:01:12','','2019-08-10 11:01:12'),('10201','Cash & Cash Equivalent','Current Asset',2,1,0,1,'A',0,NULL,NULL,0,0.00,'1','2019-06-12 11:47:24','admin','2015-10-15 15:57:55'),('1020102','Cash At Bank','Cash & Cash Equivalent',3,1,0,1,'A',0,NULL,NULL,0,0.00,'1','2019-03-18 06:08:18','admin','2015-10-15 15:32:42'),('1020101','Cash In Hand','Cash & Cash Equivalent',3,1,1,0,'A',0,NULL,NULL,0,0.00,'1','2019-01-26 07:38:48','admin','2016-05-23 12:05:43'),('102','Current Asset','Assets',1,1,0,0,'A',0,NULL,NULL,0,0.00,'','2019-08-10 11:01:12','admin','2018-07-07 11:23:00'),('502','Current Liabilities','Liabilities',1,1,0,0,'L',0,NULL,NULL,0,0.00,'anwarul','2014-08-30 13:18:20','admin','2015-10-15 19:49:21'),('1020301','Customer Receivable','Account Receivable',3,1,0,1,'A',0,NULL,NULL,0,0.00,'1','2019-01-24 12:10:05','admin','2018-07-07 12:31:42'),('50204','Employee Ledger','Current Liabilities',2,1,0,1,'L',0,NULL,NULL,0,0.00,'1','2019-04-08 10:36:32','','2019-08-10 11:01:12'),('404','Employee Salary','Expence',1,1,1,0,'E',0,NULL,NULL,0,0.00,'1','2019-05-23 05:46:14','','2019-08-10 11:01:12'),('2','Equity','COA',0,1,0,0,'L',0,NULL,NULL,0,0.00,'','2019-08-10 11:01:12','','2019-08-10 11:01:12'),('4','Expence','COA',0,1,1,0,'E',0,NULL,NULL,0,0.00,'1','2019-06-18 11:40:41','','2019-08-10 11:01:12'),('10203000002','Fajri-2','Customer Receivable',4,1,1,0,'A',0,2,NULL,0,0.00,'2','2024-08-09 23:36:40','','0000-00-00 00:00:00'),('405','Fixed Assets Cost','Expence',1,1,1,0,'E',0,NULL,NULL,0,0.00,'1','2019-05-29 05:32:01','','2019-08-10 11:01:12'),('3','Income','COA',0,1,0,0,'I',0,NULL,NULL,0,0.00,'1','2019-05-20 05:32:59','','2019-08-10 11:01:12'),('10107','Inventory','Non Current Assets',1,1,0,0,'A',0,NULL,NULL,0,0.00,'2','2018-07-07 15:21:58','','2019-08-10 11:01:12'),('502000001','Kimia Farma-1','Account Payable',3,1,1,0,'L',0,NULL,1,0,0.00,'2','2024-08-09 23:00:18','','0000-00-00 00:00:00'),('5','Liabilities','COA',0,1,0,0,'L',0,NULL,NULL,0,0.00,'admin','2013-07-04 12:32:07','admin','2015-10-15 19:46:54'),('1020302','Loan Receivable','Account Receivable',3,1,0,1,'A',0,NULL,NULL,0,0.00,'1','2019-01-26 07:37:20','','2019-08-10 11:01:12'),('101','Non Current Assets','Assets',1,1,0,0,'A',0,NULL,NULL,0,0.00,'','2019-08-10 11:01:12','admin','2015-10-15 15:29:11'),('501','Non Current Liabilities','Liabilities',1,1,0,0,'L',0,NULL,NULL,0,0.00,'anwarul','2014-08-30 13:18:20','admin','2015-10-15 19:49:21'),('402','Product Purchase','Expence',1,1,1,0,'E',0,NULL,NULL,0,0.00,'1','2019-05-20 07:46:59','','2019-08-10 11:01:12'),('304','Product Sale','Income',1,1,1,0,'I',0,NULL,NULL,0,0.00,'1','2019-06-16 12:15:40','','2019-08-10 11:01:12'),('502000003','PT Anugrah Pharmindo Lestari-3','Account Payable',3,1,1,0,'L',0,NULL,3,0,0.00,'2','2026-05-11 03:55:38','','0000-00-00 00:00:00'),('502000004','PT Enseval Putera Megatrading-4','Account Payable',3,1,1,0,'L',0,NULL,4,0,0.00,'2','2026-05-11 03:57:31','','0000-00-00 00:00:00'),('502000005','PT Mandiri Medika Farma-5','Account Payable',3,1,1,0,'L',0,NULL,5,0,0.00,'2','2026-06-07 06:24:52','','0000-00-00 00:00:00'),('502000002','PT Teknologi Medika Pratama -2','Account Payable',3,1,1,0,'L',0,NULL,2,0,0.00,'2','2026-05-11 03:53:49','','0000-00-00 00:00:00'),('305','Service Income','Income',1,1,1,0,'I',0,NULL,NULL,0,0.00,'1','2019-05-22 13:36:02','','2019-08-10 11:01:12'),('301','Store Income','Income',1,1,0,0,'I',0,NULL,NULL,0,0.00,'2','2018-07-07 13:40:37','admin','2015-09-17 17:00:02'),('50205','Supplier Ledger','Current Liabilities',2,1,0,1,'L',0,NULL,NULL,0,0.00,'1','2019-10-06 06:18:49','','2019-08-10 11:01:12'),('10203000001','Walking Customer-1','Customer Receivable',4,1,1,0,'A',0,1,NULL,0,0.00,'1','2019-11-12 07:06:55','','2019-08-10 00:00:00');
/*!40000 ALTER TABLE `acc_coa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acc_transaction`
--

DROP TABLE IF EXISTS `acc_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_transaction`
--

LOCK TABLES `acc_transaction` WRITE;
/*!40000 ALTER TABLE `acc_transaction` DISABLE KEYS */;
INSERT INTO `acc_transaction` VALUES (1,'20240809233510','Purchase','2024-08-09','10107','Inventory Debit For Purchase No20240809233510',1000000.00,0.00,'1','2','2024-08-09 23:35:10',NULL,NULL,'1'),(2,'20240809233510','Purchase','2024-08-09','502000001','Purchase No.20240809233510',0.00,1000000.00,'1','2','2024-08-09 00:00:00',NULL,NULL,'1'),(3,'20240809233510','Purchase','2024-08-09','402','Company Credit For Purchase No20240809233510',1000000.00,0.00,'1','2','2024-08-09 23:35:10',NULL,NULL,'1'),(4,'20240809233510','Purchase','2024-08-09','1020101','Cash in Hand For Purchase No20240809233510',0.00,1000000.00,'1','2','2024-08-09 23:35:10',NULL,NULL,'1'),(5,'20240809233510','Purchase','2024-08-09','502000001','Purchase No.20240809233510',1000000.00,0.00,'1','2','2024-08-09 00:00:00',NULL,NULL,'1'),(6,'20260723053701','Purchase','2026-07-23','10107','Inventory Debit For Purchase No20260723053701',1000000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-23 05:37:01',NULL,NULL,'1'),(7,'20260723053701','Purchase','2026-07-23','502000001','Purchase No.20260723053701',0.00,1000000.00,'1','RRqlFgAVhKQeiPM','2026-07-23 00:00:00',NULL,NULL,'1'),(8,'20260723053701','Purchase','2026-07-23','402','Company Credit For Purchase No20260723053701',1000000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-23 05:37:01',NULL,NULL,'1'),(9,'20260723053701','Purchase','2026-07-23','1020101','Cash in Hand For Purchase No20260723053701',0.00,1000000.00,'1','RRqlFgAVhKQeiPM','2026-07-23 05:37:01',NULL,NULL,'1'),(10,'20260723053701','Purchase','2026-07-23','502000001','Purchase No.20260723053701',1000000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-23 00:00:00',NULL,NULL,'1'),(11,'6577199165','INVOICE','2026-07-23','10107','Inventory credit For Invoice No6577199165',0.00,20000.00,'1','RRqlFgAVhKQeiPM','2026-07-23 05:39:30',NULL,NULL,'1'),(12,'6577199165','INVOICE','2026-07-23','10203000001','Customer debit For Invoice No6577199165',30000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-23 05:39:30',NULL,NULL,'1'),(13,'6577199165','INVOICE','2026-07-23','304','Customer debit For Invoice No6577199165',0.00,30000.00,'1','RRqlFgAVhKQeiPM','2026-07-23 05:39:30',NULL,NULL,'1'),(14,'6577199165','INVOICE','2026-07-23','10203000001','Customer credit for Paid Amount For Invoice No6577199165',0.00,30000.00,'1','RRqlFgAVhKQeiPM','2026-07-23 05:39:30',NULL,NULL,'1'),(15,'6577199165','INVOICE','2026-07-23','1020101','Cash in Hand For Invoice No6577199165',30000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-23 05:39:30',NULL,NULL,'1'),(16,'3672378217','INVOICE','2026-07-28','10107','Inventory credit For Invoice No3672378217',0.00,100000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:26:06',NULL,NULL,'1'),(17,'3672378217','INVOICE','2026-07-28','10203000001','Customer debit For Invoice No3672378217',150000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:26:06',NULL,NULL,'1'),(18,'3672378217','INVOICE','2026-07-28','304','Customer debit For Invoice No3672378217',0.00,150000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:26:06',NULL,NULL,'1'),(19,'3672378217','INVOICE','2026-07-28','10203000001','Customer credit for Paid Amount For Invoice No3672378217',0.00,150000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:26:06',NULL,NULL,'1'),(20,'3672378217','INVOICE','2026-07-28','1020101','Cash in Hand For Invoice No3672378217',150000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:26:06',NULL,NULL,'1'),(21,'9595872336','INVOICE','2026-07-28','10107','Inventory credit For Invoice No9595872336',0.00,100000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:26:08',NULL,NULL,'1'),(22,'9595872336','INVOICE','2026-07-28','10203000001','Customer debit For Invoice No9595872336',150000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:26:08',NULL,NULL,'1'),(23,'9595872336','INVOICE','2026-07-28','304','Customer debit For Invoice No9595872336',0.00,150000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:26:08',NULL,NULL,'1'),(24,'9595872336','INVOICE','2026-07-28','10203000001','Customer credit for Paid Amount For Invoice No9595872336',0.00,150000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:26:08',NULL,NULL,'1'),(25,'9595872336','INVOICE','2026-07-28','1020101','Cash in Hand For Invoice No9595872336',150000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:26:08',NULL,NULL,'1'),(26,'6392593487','INVOICE','2026-07-28','10107','Inventory credit For Invoice No6392593487',0.00,50000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:32:11',NULL,NULL,'1'),(27,'6392593487','INVOICE','2026-07-28','10203000001','Customer debit For Invoice No6392593487',75000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:32:11',NULL,NULL,'1'),(28,'6392593487','INVOICE','2026-07-28','304','Customer debit For Invoice No6392593487',0.00,75000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:32:11',NULL,NULL,'1'),(29,'6392593487','INVOICE','2026-07-28','10203000001','Customer credit for Paid Amount For Invoice No6392593487',0.00,100000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:32:11',NULL,NULL,'1'),(30,'6392593487','INVOICE','2026-07-28','1020101','Cash in Hand For Invoice No6392593487',100000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:32:11',NULL,NULL,'1'),(31,'8122339382','INVOICE','2026-07-28','10107','Inventory credit For Invoice No8122339382',0.00,100000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:41:22',NULL,NULL,'1'),(32,'8122339382','INVOICE','2026-07-28','10203000001','Customer debit For Invoice No8122339382',150000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:41:22',NULL,NULL,'1'),(33,'8122339382','INVOICE','2026-07-28','304','Customer debit For Invoice No8122339382',0.00,150000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:41:22',NULL,NULL,'1'),(34,'8122339382','INVOICE','2026-07-28','10203000001','Customer credit for Paid Amount For Invoice No8122339382',0.00,200000.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:41:22',NULL,NULL,'1'),(35,'8122339382','INVOICE','2026-07-28','1020101','Cash in Hand For Invoice No8122339382',200000.00,0.00,'1','RRqlFgAVhKQeiPM','2026-07-28 03:41:22',NULL,NULL,'1');
/*!40000 ALTER TABLE `acc_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_purchase`
--

DROP TABLE IF EXISTS `asset_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asset_purchase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `p_date` date NOT NULL,
  `supplier_id` varchar(30) NOT NULL,
  `grand_total` float NOT NULL,
  `payment_type` tinyint(4) DEFAULT NULL,
  `bank_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_purchase`
--

LOCK TABLES `asset_purchase` WRITE;
/*!40000 ALTER TABLE `asset_purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `asset_purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendance` (
  `att_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `sign_in` varchar(30) NOT NULL,
  `sign_out` varchar(30) NOT NULL,
  `staytime` varchar(30) NOT NULL,
  PRIMARY KEY (`att_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance`
--

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_add`
--

DROP TABLE IF EXISTS `bank_add`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_add`
--

LOCK TABLES `bank_add` WRITE;
/*!40000 ALTER TABLE `bank_add` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_add` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_information`
--

DROP TABLE IF EXISTS `company_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_information` (
  `company_id` varchar(50) NOT NULL,
  `company_name` varchar(250) NOT NULL,
  `email` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `mobile` varchar(30) NOT NULL,
  `website` varchar(50) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_information`
--

LOCK TABLES `company_information` WRITE;
/*!40000 ALTER TABLE `company_information` DISABLE KEYS */;
INSERT INTO `company_information` VALUES ('NOILG8EGCRXXBWUEUQBM','APOTEK ALANG FARMA','apotekalang@gmail.com','Jl.  KH. Tajudin RT. 06 / RW. 03 Kel. Bahagia, Kec. Babelan Bekasi','081278480303','http://www.apotek-alang.com',1);
/*!40000 ALTER TABLE `company_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_tbl`
--

DROP TABLE IF EXISTS `currency_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency_tbl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_name` varchar(50) NOT NULL,
  `icon` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_tbl`
--

LOCK TABLES `currency_tbl` WRITE;
/*!40000 ALTER TABLE `currency_tbl` DISABLE KEYS */;
INSERT INTO `currency_tbl` VALUES (1,'Rupiah','Rp'),(2,'Dollar','$');
/*!40000 ALTER TABLE `currency_tbl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_information`
--

DROP TABLE IF EXISTS `customer_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_information`
--

LOCK TABLES `customer_information` WRITE;
/*!40000 ALTER TABLE `customer_information` DISABLE KEYS */;
INSERT INTO `customer_information` VALUES (1,'Walking Customer','','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2020-07-22 16:17:45',NULL),(2,'Fajri','','','08892970567','','','','','','','','',' ',2,'2024-08-09 23:36:40','2');
/*!40000 ALTER TABLE `customer_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `daily_closing`
--

DROP TABLE IF EXISTS `daily_closing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_closing`
--

LOCK TABLES `daily_closing` WRITE;
/*!40000 ALTER TABLE `daily_closing` DISABLE KEYS */;
/*!40000 ALTER TABLE `daily_closing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `designation`
--

DROP TABLE IF EXISTS `designation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `designation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `designation` varchar(150) NOT NULL,
  `details` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `designation`
--

LOCK TABLES `designation` WRITE;
/*!40000 ALTER TABLE `designation` DISABLE KEYS */;
/*!40000 ALTER TABLE `designation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_history`
--

DROP TABLE IF EXISTS `employee_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_history`
--

LOCK TABLES `employee_history` WRITE;
/*!40000 ALTER TABLE `employee_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_salary_payment`
--

DROP TABLE IF EXISTS `employee_salary_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_salary_payment`
--

LOCK TABLES `employee_salary_payment` WRITE;
/*!40000 ALTER TABLE `employee_salary_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_salary_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_salary_setup`
--

DROP TABLE IF EXISTS `employee_salary_setup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_salary_setup`
--

LOCK TABLES `employee_salary_setup` WRITE;
/*!40000 ALTER TABLE `employee_salary_setup` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee_salary_setup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense`
--

DROP TABLE IF EXISTS `expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `type` varchar(100) NOT NULL,
  `voucher_no` varchar(50) NOT NULL,
  `amount` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense`
--

LOCK TABLES `expense` WRITE;
/*!40000 ALTER TABLE `expense` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense_item`
--

DROP TABLE IF EXISTS `expense_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_item_name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_item`
--

LOCK TABLES `expense_item` WRITE;
/*!40000 ALTER TABLE `expense_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fixed_assets`
--

DROP TABLE IF EXISTS `fixed_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fixed_assets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_code` varchar(50) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `price` float NOT NULL,
  `insert_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fixed_assets`
--

LOCK TABLES `fixed_assets` WRITE;
/*!40000 ALTER TABLE `fixed_assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `fixed_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES (1,6577199165,1,'2026-07-23',30000.00,1000,0.00,0.00,0.00,0.00,'RRqlFgAVhKQeiPM','',1,1,NULL),(2,3672378217,1,'2026-07-28',150000.00,1001,0.00,0.00,0.00,0.00,'RRqlFgAVhKQeiPM',NULL,1,1,NULL),(3,9595872336,1,'2026-07-28',150000.00,1002,0.00,0.00,0.00,0.00,'RRqlFgAVhKQeiPM',NULL,1,1,NULL),(4,6392593487,1,'2026-07-28',75000.00,1003,0.00,0.00,0.00,0.00,'RRqlFgAVhKQeiPM',NULL,1,1,NULL),(5,8122339382,1,'2026-07-28',150000.00,1004,0.00,0.00,0.00,0.00,'RRqlFgAVhKQeiPM','',1,1,NULL);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_details`
--

DROP TABLE IF EXISTS `invoice_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_details`
--

LOCK TABLES `invoice_details` WRITE;
/*!40000 ALTER TABLE `invoice_details` DISABLE KEYS */;
INSERT INTO `invoice_details` VALUES (1,'231438739475713',6577199165,'1234567890','2-1',NULL,2,15000.00,10000.00,30000.00,0,0.00,30000,0.00,1),(2,'815291753153395',3672378217,'1234567890','2-1',NULL,10,15000.00,10000.00,150000.00,0,0.00,150000,0.00,1),(3,'318937318742473',9595872336,'1234567890','2-1',NULL,10,15000.00,10000.00,150000.00,0,0.00,150000,0.00,1),(4,'946236614649444',6392593487,'1234567890','2-1',NULL,5,15000.00,10000.00,75000.00,0,0.00,100000,0.00,1),(5,'161413425664797',8122339382,'1234567890','2-1',NULL,10,15000.00,10000.00,150000.00,0,0.00,200000,0.00,1);
/*!40000 ALTER TABLE `invoice_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `phrase` text NOT NULL,
  `english` text DEFAULT NULL,
  `bahasa` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=982 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'user_profile','User Profile','Profil Pengguna'),(2,'setting','Web Setting','Pengaturan Web'),(3,'language','Language','Bahasa'),(4,'manage_users','Manage Users','Kelola Pengguna'),(5,'add_user','Add User','Tambahkan Pengguna'),(6,'manage_company','Manage Company','Mengelola Perusahaan'),(7,'web_settings','Software Settings','Pengaturan Perangkat Lunak'),(8,'manage_accounts','Manage Accounts','Kelola Akun'),(9,'create_accounts','Create Accounts','Buat Akun'),(10,'manage_bank','Manage Bank','Kelola Bank'),(11,'add_new_bank','Add New Bank','Tambahkan Bank Baru'),(12,'settings','Settings','Pengaturan'),(13,'closing_report','Closing Report','Laporan Penutup'),(14,'closing','Closing','Penutupan'),(15,'cheque_manager','Cheque Manager','Manajer Cek'),(16,'accounts_summary','Accounts Summary','Ringkasan Akun'),(17,'expense','Expense','Pengeluaran'),(18,'income','Income','Penghasilan'),(19,'accounts','Accounts','Akun'),(20,'stock_report','Stock Report','Laporan Stok'),(21,'stock','Stock','Stok'),(22,'pos_invoice','POS Invoice','Transaksi POS'),(23,'manage_invoice','Manage Invoice','Kelola Transaksi'),(24,'new_invoice','New Invoice','Transaksi Baru'),(25,'invoice','Invoice','Transaksi'),(26,'manage_purchase','Manage Purchase','Kelola Pembelian'),(27,'add_purchase','Add Purchase','Tambahkan Pembelian'),(28,'purchase','Purchase','Pembelian'),(29,'paid_customer','Paid Customer','Pelanggan Berbayar'),(30,'manage_customer','Manage Customer','Kelola Pelanggan'),(31,'add_customer','Add Customer','Tambahkan Pelanggan'),(32,'customer','Customer','Pelanggan'),(33,'manufacturer_payment_actual','Distributor Payment Actual','Pembayaran Distributor Aktual'),(34,'manufacturer_sales_summary','Distributor  Sales Summary','Ringkasan Penjualan Distributor'),(35,'manufacturer_sales_details','Distributor Sales Details','Rincian Penjualan Distributor'),(36,'manufacturer_ledger','Distributor Ledger','Buku Besar Distributor'),(37,'manage_manufacturer','Manage Distributor','Kelola Distributor'),(38,'add_manufacturer','Add Distributor','Tambahkan Distributor'),(39,'manufacturer','Distributor','Distributor'),(40,'product_statement','Medicine Statement','Pernyataan Obat'),(41,'manage_product','Manage Medicine','Mengelola Pengobatan'),(42,'add_product','Add Medicine','Tambahkan Obat'),(43,'product','Medicine','Obat'),(44,'manage_category','Manage Category','Kelola Kategori'),(45,'add_category','Add Category','Tambahkan Kategori'),(46,'category','Category','Kategori'),(47,'sales_report_product_wise','Sales Report (Medicine Wise)','Laporan Penjualan (Medis Wise)'),(48,'purchase_report','Purchase Report','Laporan Pembelian'),(49,'sales_report','Sales Report','Laporan Penjualan'),(50,'todays_report','Todays Report','Laporan Hari Ini'),(51,'report','Report','Laporan'),(52,'dashboard','Dashboard','Dashboard'),(53,'online','Online','Online'),(54,'logout','Logout','Keluar'),(56,'total_purchase','Total Purchase','Total Pembelian'),(57,'total_amount','Total Amount','Jumlah Total'),(58,'manufacturer_name','Distributor  Name','Nama Distributor'),(59,'invoice_no','Invoice No','Nomor Faktur'),(60,'purchase_date','Purchase Date','Tanggal Pembelian'),(61,'todays_purchase_report','Todays Purchase Report','Laporan Pembelian Hari Ini'),(62,'total_sales','Total Sales','Total Penjualan'),(63,'customer_name','Customer Name','Nama Pelanggan'),(64,'sales_date','Sales Date','Tanggal Penjualan'),(65,'todays_sales_report','Todays Sales Report','Laporan Penjualan Hari Ini'),(66,'home','Home','Rumah'),(67,'todays_sales_and_purchase_report','Todays sales and purchase report','Laporan penjualan dan pembelian hari ini'),(68,'total_ammount','Total Amount','Jumlah Total'),(69,'rate','Sale Price','Harga penjualan'),(70,'product_model','Medicine Type','Jenis Obat'),(71,'product_name','Medicine Name','Nama Obat'),(72,'search','Search','Mencari'),(73,'end_date','End Date','Tanggal Akhir'),(74,'start_date','Start Date','Tanggal Mulai'),(75,'total_purchase_report','Total Purchase Report','Laporan Total Pembelian'),(76,'total_sales_report','Total Sales Report','Laporan Total Penjualan'),(77,'total_seles','Total Sales','Total Penjualan'),(78,'all_stock_report','All Stock Report','Laporan Seluruh Stok'),(79,'search_by_product','Search By Medicine','Cari Berdasarkan Obat'),(80,'date','Date','Tanggal'),(81,'print','Print','Mencetak'),(82,'stock_date','Stock Date','Tanggal Stok'),(83,'print_date','Print Date','Tanggal Cetak'),(84,'sales','Sales','Penjualan'),(85,'price','Price','Harga'),(86,'sl','SL.','SL.'),(87,'add_new_category','Add new category','Tambahkan kategori baru'),(88,'category_name','Category Name','Nama Kategori'),(89,'save','Save','Menyimpan'),(90,'delete','Delete','Menghapus'),(91,'update','Update','Memperbarui'),(92,'action','Action','Tindakan'),(93,'manage_your_category','Manage your category','Kelola kategori Anda'),(94,'category_edit','Category Edit','Edit Kategori'),(95,'status','Status','Status'),(96,'active','Active','Aktif'),(97,'inactive','Inactive','Tidak aktif'),(98,'save_changes','Save Changes','Simpan Perubahan'),(99,'save_and_add_another','Save And Add Another','Simpan dan Tambahkan yang Lain'),(100,'model','Medicine Type','Jenis Obat'),(101,'manufacturer_price','Distributor Price','Harga Distributor'),(102,'sell_price','Sell Price','Harga Jual'),(103,'image','Image','Gambar'),(104,'select_one','Select One','Pilih Salah Satu'),(105,'details','Details','Detail'),(106,'new_product','New Medicine','Obat Baru'),(107,'add_new_product','Add new medicine','Tambahkan obat baru'),(108,'barcode','Barcode','Kode batang'),(109,'qr_code','Qr-Code','Kode QR'),(110,'product_details','Medicine Details','Rincian Obat'),(111,'manage_your_product','Manage your medicine','Kelola pengobatan Anda'),(112,'product_edit','Medicine Edit','Suntingan Obat'),(113,'edit_your_product','Edit your medicine','Edit obat Anda'),(114,'cancel','Cancel','Membatalkan'),(115,'incl_vat','Incl. Vat','Termasuk PPN'),(116,'money','Dollar','Dolar'),(117,'grand_total','Grand Total','Jumlah Total'),(118,'quantity','Quantity','Kuantitas'),(119,'product_report','Medicine Report','Laporan Obat-obatan'),(120,'product_sales_and_purchase_report','Medicine sales and purchase report','Laporan penjualan dan pembelian obat-obatan'),(121,'previous_stock','Previous Stock','Stok Sebelumnya'),(122,'out','Out','Keluar'),(123,'in','In','Di dalam'),(124,'to','To','Ke'),(125,'previous_balance','Previous Balance','Saldo Sebelumnya'),(126,'customer_address','Customer Address','Alamat Pelanggan'),(127,'customer_mobile','Customer Mobile','Ponsel Pelanggan'),(128,'customer_email','Customer Email','Email Pelanggan'),(129,'add_new_customer','Add new customer','Tambahkan pelanggan baru'),(130,'balance','Balance','Keseimbangan'),(131,'mobile','Mobile','Ponsel'),(132,'address','Address','Alamat'),(133,'manage_your_customer','Manage your customer','Kelola pelanggan Anda'),(134,'customer_edit','Customer Edit','Edit Pelanggan'),(135,'paid_customer_list','Paid Customer List','Daftar Pelanggan Berbayar'),(136,'ammount','Amount','Jumlah'),(137,'customer_ledger','Customer Ledger','Buku Besar Pelanggan'),(138,'manage_customer_ledger','Manage Customer Ledger','Kelola Buku Besar Pelanggan'),(139,'customer_information','Customer Information','Informasi Pelanggan'),(140,'debit_ammount','Debit Amount','Jumlah Debit'),(141,'credit_ammount','Credit Amount','Jumlah Kredit'),(142,'balance_ammount','Balance Amount','Jumlah Saldo'),(143,'receipt_no','Receipt NO','Nomor Kwitansi'),(144,'description','Description','Keterangan'),(145,'debit','Debit','Debet'),(146,'credit','Credit','Kredit'),(147,'item_information','Item Information','Informasi Barang'),(148,'total','Total','Total'),(149,'please_select_manufacturer','Please Select Distributor','Silakan Pilih Distributor'),(150,'submit','Submit','Kirim'),(151,'submit_and_add_another','Submit And Add Another One','Kirim dan Tambahkan yang Lain'),(152,'add_new_item','Add New Item','Tambahkan Item Baru'),(153,'manage_your_purchase','Manage your purchase','Kelola pembelian Anda'),(154,'purchase_edit','Purchase Edit','Beli Edit'),(155,'purchase_ledger','Purchase Ledger','Buku Besar Pembelian'),(156,'invoice_information','Invoice Information','Informasi Faktur'),(157,'paid_ammount','Paid Amount','Jumlah yang Dibayarkan'),(158,'discount','Discount / Pcs.','Diskon / Pcs.'),(159,'save_and_paid','Save And Paid','Simpan dan Bayar'),(160,'payee_name','Payee Name','Nama Penerima Pembayaran'),(161,'manage_your_invoice','Manage your invoice','Kelola faktur Anda'),(162,'invoice_edit','Invoice Edit','Edit Faktur'),(163,'new_pos_invoice','New POS invoice','Faktur POS baru'),(164,'add_new_pos_invoice','Add new pos invoice','Tambahkan faktur POS baru'),(165,'product_id','Medicine ID','ID Obat'),(166,'paid_amount','Paid Amount','Jumlah yang Dibayarkan'),(167,'authorised_by','Authorised By','Diotorisasi Oleh'),(168,'checked_by','Checked By','Diperiksa oleh'),(169,'received_by','Received By','Diterima Oleh'),(170,'prepared_by','Prepared By','Disiapkan Oleh'),(171,'memo_no','Memo No','Nomor Memo'),(172,'website','Website','Situs web'),(173,'email','Email','E-mail'),(174,'invoice_details','Invoice Details','Rincian Faktur'),(175,'reset','Reset','Mengatur ulang'),(176,'payment_account','Payment Account','Rekening Pembayaran'),(177,'bank_name','Bank Name','Nama Bank'),(178,'cheque_or_pay_order_no','Cheque/Pay Order No','Nomor Cek/Wesel Pembayaran'),(179,'payment_type','Payment Type','Jenis Pembayaran'),(180,'payment_from','Payment From','Pembayaran Dari'),(181,'payment_date','Payment Date','Tanggal Pembayaran'),(182,'add_income','Add Income','Menambah Penghasilan'),(183,'cash','Cash','Uang tunai'),(184,'cheque','Cheque','Memeriksa'),(185,'pay_order','Pay Order','Pesanan Pembayaran'),(186,'payment_to','Payment To','Pembayaran Kepada'),(187,'total_expense_ammount','Total Expense Amount','Jumlah Total Pengeluaran'),(188,'transections','Transactions','Transaksi'),(189,'accounts_name','Accounts Name','Nama Akun'),(190,'outflow_report','Expense Report','Laporan Pengeluaran'),(191,'inflow_report','Income Report','Laporan Pendapatan'),(192,'all','All','Semua'),(193,'account','Account','Akun'),(194,'from','From','Dari'),(195,'account_summary_report','Account Summary Report','Laporan Ringkasan Akun'),(196,'search_by_date','Search By Date','Cari Berdasarkan Tanggal'),(197,'cheque_no','Cheque No','Nomor Cek'),(198,'name','Name','Nama'),(199,'closing_account','Closing Account','Penutupan Akun'),(200,'close_your_account','Close your account','Tutup akun Anda'),(201,'last_day_closing','Last Day Closing','Hari Terakhir Penutupan'),(202,'cash_in','Cash In','Uang Tunai'),(203,'cash_out','Cash Out','Penarikan Tunai'),(204,'cash_in_hand','Cash In Hand','Uang tunai'),(205,'add_new_bank','Add New Bank','Tambahkan Bank Baru'),(206,'day_closing','Day Closing','Penutupan Hari'),(207,'account_closing_report','Account Closing Report','Laporan Penutupan Akun'),(208,'last_day_ammount','Last Day Amount','Jumlah Hari Terakhir'),(209,'adjustment','Adjustment','Pengaturan'),(210,'pay_type','Pay Type','Jenis Pembayaran'),(211,'customer_or_manufacturer','Customer, Distributor Or Others','Pelanggan, Distributor, atau Pihak Lainnya'),(212,'transection_id','Transactions ID','ID Transaksi'),(213,'accounts_summary_report','Accounts Summary Report','Laporan Ringkasan Akun'),(214,'bank_list','Bank List','Daftar Bank'),(215,'bank_edit','Bank Edit','Pengeditan Bank'),(216,'debit_plus','Debit (+)','Debit (+)'),(217,'credit_minus','Credit (-)','Kredit (-)'),(218,'account_name','Account Name','Nama Akun'),(219,'account_type','Account Type','Jenis Akun'),(220,'account_real_name','Account Real Name','Nama Asli Akun'),(221,'manage_account','Manage Account','Kelola Akun'),(222,'company_name','Company Name','Nama perusahaan'),(223,'edit_your_company_information','Edit your company information','Edit informasi perusahaan Anda'),(224,'company_edit','Company Edit','Suntingan Perusahaan'),(225,'admin','Admin','Admin'),(226,'user','User','Pengguna'),(227,'password','Password','Kata sandi'),(228,'last_name','Last Name','Nama Belakang'),(229,'first_name','First Name','Nama depan'),(230,'add_new_user_information','Add new user information','Tambahkan informasi pengguna baru'),(231,'user_type','User Type','Jenis Pengguna'),(232,'user_edit','User Edit','Pengeditan Pengguna'),(233,'rtr','RTR','RTR'),(234,'ltr','LTR','LTR'),(235,'ltr_or_rtr','LTR/RTR','LTR/RTR'),(236,'footer_text','Footer Text','Teks Footer'),(237,'favicon','Favicon','Favicon'),(238,'logo','Logo','Logo'),(239,'update_setting','Update Setting','Perbarui Pengaturan'),(240,'update_your_web_setting','Update your Web setting','Perbarui pengaturan web Anda'),(241,'login','Login','Login'),(242,'your_strong_password','Your strong password','Kata sandi Anda yang kuat'),(243,'your_unique_email','Your unique email','Email unik Anda'),(244,'please_enter_your_login_information','Please enter your login information.','Silakan masukkan informasi login Anda.'),(245,'update_profile','Update Profile','Perbarui Profil'),(246,'your_profile','Your Profile','Profil Anda'),(247,'re_type_password','Re-Type Password','Ketik Ulang Kata Sandi'),(248,'new_password','New Password','Kata Sandi Baru'),(249,'old_password','Old Password','Kata Sandi Lama'),(250,'new_information','New Information','Informasi Baru'),(251,'old_information','Old Information','Informasi Lama'),(252,'change_your_information','Change your information','Ubah informasi Anda'),(253,'change_your_profile','Change your profile','Ubah profil Anda'),(254,'profile','Profile','Profil'),(255,'wrong_username_or_password','Wrong User Name Or Password !','Nama Pengguna atau Kata Sandi Salah!'),(256,'successfully_updated','Successfully Updated.','Pembaruan berhasil.'),(257,'blank_field_does_not_accept','Blank Field Does Not Accept !','Kolom Kosong Tidak Menerima !'),(258,'successfully_changed_password','Successfully changed password.','Kata sandi berhasil diubah.'),(259,'you_are_not_authorised_person','You are not authorised person !','Anda bukan orang yang berwenang!'),(260,'password_and_repassword_does_not_match','Passwor and re-password does not match !','Kata sandi dan pengaturan ulang kata sandi tidak cocok!'),(261,'new_password_at_least_six_character','New Password At Least 6 Character.','Kata Sandi Baru Minimal 6 Karakter.'),(262,'you_put_wrong_email_address','You put wrong email address !','Anda memasukkan alamat email yang salah!'),(263,'cheque_ammount_asjusted','Cheque amount adjusted.','Jumlah cek disesuaikan.'),(264,'successfully_payment_paid','Successfully Payment Paid.','Pembayaran Berhasil.'),(265,'successfully_added','Successfully Added.','Berhasil ditambahkan.'),(266,'successfully_updated_2_closing_ammount_not_changeale','Successfully Updated -2. Note: Closing Amount Not Changeable.','Pembaruan Berhasil -2. Catatan: Jumlah Penutupan Tidak Dapat Diubah.'),(267,'successfully_payment_received','Successfully Payment Received.','Pembayaran berhasil diterima.'),(268,'already_inserted','Already Inserted !','Sudah dimasukkan!'),(269,'successfully_delete','Successfully Delete.','Penghapusan berhasil.'),(270,'successfully_created','Successfully Created.','Berhasil Dibuat.'),(271,'logo_not_uploaded','Logo not uploaded !','Logo belum diunggah!'),(272,'favicon_not_uploaded','Favicon not uploaded !','Favicon belum diunggah!'),(273,'manufacturer_mobile','Distributor  Mobile','Distributor Mobile'),(274,'manufacturer_address','Distributor  Address','Alamat Distributor'),(275,'manufacturer_details','Distributor Details','Detail Distributor'),(276,'add_new_manufacturer','Add New Distributor','Tambahkan Distributor Baru'),(277,'manage_suppiler','Manage Distributor','Kelola Distributor'),(278,'manage_your_manufacturer','Manage your Distributor','Kelola Distributor Anda'),(279,'manage_manufacturer_ledger','Manage Distributor','Kelola Distributor'),(280,'invoice_id','Invoice ID','ID Faktur'),(281,'deposite_id','Deposit ID','ID Setoran'),(282,'manufacturer_actual_ledger','Distributor Actual Ledger','Buku Besar Aktual Distributor'),(283,'manufacturer_information','Distributor Information','Informasi Distributor'),(284,'event','Event','Peristiwa'),(285,'add_new_income','Add New Income','Tambahkan Penghasilan Baru'),(286,'add_expese','Add Expense','Tambahkan Biaya'),(287,'add_new_expense','Add New Expense','Tambahkan Pengeluaran Baru'),(288,'total_income_ammount','Total Income Amount','Jumlah Pendapatan Total'),(289,'create_new_invoice','Create New Invoice','Buat Faktur Baru'),(290,'create_pos_invoice','Create POS Invoice','Buat Faktur POS'),(291,'total_profit','Total Profit','Total Keuntungan'),(292,'monthly_progress_report','Monthly Progress Report','Laporan Kemajuan Bulanan'),(293,'total_invoice','Total Invoice','Total Tagihan'),(294,'account_summary','Account Summary','Ringkasan Akun'),(295,'total_manufacturer','Total Distributor','Distributor Total'),(296,'total_product','Total Medicine','Pengobatan Total'),(297,'total_customer','Total Customer','Jumlah Pelanggan'),(298,'manufacturer_edit','Distributor Edit','Penyuntingan Distributor'),(299,'add_new_invoice','Add New Invoice','Tambahkan Faktur Baru'),(300,'add_new_purchase','Add new purchase','Tambahkan pembelian baru'),(301,'currency','Currency','Mata uang'),(302,'currency_position','Currency Position','Posisi Mata Uang'),(303,'left','Left','Kiri'),(304,'right','Right','Benar'),(305,'add_tax','Add Tax','Tambahkan Pajak'),(306,'manage_tax','Manage Tax','Kelola Pajak'),(307,'add_new_tax','Add new tax','Tambahkan pajak baru'),(308,'enter_tax','Enter Tax','Masukkan Pajak'),(309,'already_exists','Already Exists !','Sudah Ada!'),(310,'successfully_inserted','Successfully Inserted.','Berhasil dimasukkan.'),(311,'tax','Tax','Pajak'),(312,'tax_edit','Tax Edit','Suntingan Pajak'),(313,'product_not_added','Medicine not added !','Obat tidak ditambahkan!'),(314,'total_tax','Total Tax','Total Pajak'),(315,'manage_your_manufacturer_details','Manage your Distributor','Kelola Distributor Anda'),(316,'invoice_description','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s                                       standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.','Lorem Ipsum hanyalah teks contoh yang digunakan dalam industri percetakan dan penataan huruf. Lorem Ipsum telah menjadi teks contoh standar industri sejak tahun 1500-an, ketika seorang pencetak yang tidak dikenal mengambil susunan huruf dan mengacaknya untuk membuat buku contoh huruf.'),(317,'thank_you_for_choosing_us','Thank you very much for choosing us.','Terima kasih banyak telah memilih kami.'),(318,'billing_date','Billing Date','Tanggal Penagihan'),(319,'billing_to','Billing To','Penagihan Kepada'),(320,'billing_from','Billing From','Penagihan Dari'),(321,'you_cant_delete_this_product','Sorry !!  You can\'t delete this medicine.This medicine already used in calculation system!','Maaf!! Anda tidak dapat menghapus obat ini. Obat ini sudah digunakan dalam sistem perhitungan!'),(322,'old_customer','Old Customer','Pelanggan Lama'),(323,'new_customer','New Customer','Pelanggan Baru'),(324,'new_manufacturer','New Distributor','Distributor Baru'),(325,'old_manufacturer','Old Distributor','Distributor Lama'),(326,'credit_customer','Credit Customer','Pelanggan Kredit'),(327,'account_already_exists','This Account Already Exists !','Akun ini sudah ada!'),(328,'edit_income','Edit Income','Edit Pendapatan'),(329,'you_are_not_access_this_part','You are not authorised person !','Anda bukan orang yang berwenang!'),(330,'account_edit','Account Edit','Edit Akun'),(331,'due','Due','Jatuh tempo'),(332,'expense_edit','Expense Edit','Edit Pengeluaran'),(333,'please_select_customer','Please select customer !','Silakan pilih pelanggan!'),(334,'profit_report','Profit Report (Invoice Wise)','Laporan Laba (Per Faktur)'),(335,'total_profit_report','Total profit report','Laporan laba total'),(336,'please_enter_valid_captcha','Please enter valid captcha.','Silakan masukkan captcha yang valid.'),(337,'category_not_selected','Category not selected.','Kategori tidak dipilih.'),(338,'manufacturer_not_selected','Distributor not selected.','Distributor tidak terpilih.'),(339,'please_select_product','Please select medicine','Silakan pilih obat'),(340,'product_model_already_exist','Medicine model already exist !','Model pengobatan sudah ada!'),(341,'invoice_logo','Invoice Logo','Logo Faktur'),(342,'available_quantity','Available Quantity','Jumlah yang Tersedia'),(343,'you_can_not_buy_greater_than_available_quantity','You can not select grater than availale quantity !','Anda tidak dapat memilih lebih dari jumlah yang tersedia!'),(344,'customer_details','Customer details','Detail pelanggan'),(345,'manage_customer_details','Manage customer details.','Kelola detail pelanggan.'),(346,'box_size','Box size','Ukuran kotak'),(347,'expire_date','Expiry  date','Tanggal kedaluwarsa'),(348,'product_location','Medicine  Shelf','Rak Obat'),(349,'generic_name','Generic name','Nama generik'),(350,'payment_method','Payment Method','Metode Pembayaran'),(351,'card_no','Card no','Nomor kartu'),(352,'medicine','Medicine','Obat'),(353,'medicine_search','Medicine Search','Pencarian Obat'),(354,'what_you_search','Enter what you search','Masukkan apa yang Anda cari'),(355,'company','Company','Perusahaan'),(356,'customer_search','Customer search','Pencarian pelanggan'),(357,'invoice_search','Invoice search','Pencarian faktur'),(358,'purchase_search','Purchase search','Pencarian pembelian'),(359,'daily_closing_report','Daily closing report.','Laporan penutupan harian.'),(360,'closing_search_report','Closing Search Report','Laporan Penutupan Pencarian'),(361,'category_list','Category List','Daftar Kategori'),(362,'company_list','Company List','Daftar Perusahaan'),(363,'customers_list','Customer List','Daftar Pelanggan'),(364,'credit_customer_list','Credit Customer List','Daftar Pelanggan Kredit'),(365,'previous_balance_adjustment','Previous Balance Adjustment','Penyesuaian Saldo Sebelumnya'),(366,'invoice_list','Invoice List','Daftar Faktur'),(367,'add_pos_invoice','Add POS Invoice','Tambahkan Faktur POS'),(368,'add_invoice','Add Invoice','Tambahkan Faktur'),(369,'product_list','Medicine List','Daftar Obat'),(370,'purchases_list','Purchase List','Daftar Pembelian'),(371,'purchase_list','Purchase List','Daftar Pembelian'),(372,'stock_list','Stock List','Daftar Stok'),(373,'all_report','All Report','Semua Laporan'),(374,'daily_sales_report','Daily sales Report','Laporan Penjualan Harian'),(375,'product_wise_sales_report','Medicine Wise Sales Report','Laporan Penjualan Obat-obatan yang Bijaksana'),(376,'bank_update','Bank Update','Pembaruan Bank'),(377,'account_list','Account List','Daftar Akun'),(378,'manufacturer_list','Distributor  List','Daftar Distributor'),(379,'manufacturer_search_item','Distributor  Search Item','Barang Pencarian Distributor'),(380,'user_list','User List','Daftar Pengguna'),(381,'user_search_item','User Search Item','Item Pencarian Pengguna'),(382,'change_password','Change Password','Ubah Kata Sandi'),(383,'admin_login_area','Admin Login Area','Area Login Admin'),(384,'accounts_inflow_form','Account Inflow Form','Formulir Arus Masuk Akun'),(385,'accounts_outflow_form','Accounts Outflow Form','Formulir Arus Keluar Akun'),(386,'accounts_tax_form','Accounts Tax Form','Formulir Pajak Akun'),(387,'accounts_manage_tax','Accounts Manage Tax','Akun Mengelola Pajak'),(388,'accounts_tax_edit','Accounts Tax Edit','Edit Pajak Akun'),(389,'accounts_summary_data','Accounts Summary Data','Ringkasan Data Akun'),(390,'accounts_details_data','Accounts Details Data','Data Rincian Akun'),(391,'datewise_summary_data','Datewise Summary Data','Ringkasan Data Berdasarkan Tanggal'),(392,'accounts_cheque_manager','Account Cheque Manager','Manajer Cek Akun'),(393,'accounts_edit_data','Accounts Edit Data','Edit Data Akun'),(394,'print_barcode','Print Barcode','Cetak Kode Batang'),(395,'print_qrcode','Print Qrcode','Cetak Kode QR'),(396,'add_new_account','Add New Account','Tambahkan Akun Baru'),(397,'table_edit','Table Edit','Pengeditan Tabel'),(398,'secret_key','Secret Key','Kunci Rahasia'),(399,'site_key','Site Key','Kunci Situs'),(400,'captcha','Captcha','Captcha'),(401,'please_add_walking_customer_for_default_customer','Please add walking customer for default customer.','Mohon tambahkan pelanggan yang berjalan kaki sebagai pelanggan default.'),(402,'barcode_qrcode_scan_here','Barcode Or QRcode scan here','Pindai kode batang atau kode QR di sini.'),(403,'manage_your_credit_customer','Manage your credit customer','Kelola pelanggan kredit Anda'),(404,'unit','Unit','Satuan'),(405,'total_discount','Total Discount','Total Diskon'),(406,'meter_m','Meter (M)','Meter (M)'),(407,'piece_pc','Piece (Pc)','Buah (Pc)'),(408,'kilogram_kg','Kilogram (Kg)','Kilogram (Kg)'),(409,'import_product_csv','Import Medicine (CSV)','Impor Obat (CSV)'),(410,'close','Close','Menutup'),(411,'csv_file_informaion','File Information (CSV)','Informasi File (CSV)'),(412,'download_example_file','Download Example File','Unduh File Contoh'),(413,'upload_csv_file','Upload CSV File','Unggah File CSV'),(414,'manufacturer_id','Distributor ID','ID Distributor'),(415,'category_id','Category ID','ID Kategori'),(416,'are_you_sure_to_delete','Are you sure,want to delete ?','Apakah Anda yakin ingin menghapusnya?'),(417,'stock_report_manufacturer_wise','Stock Report (Manufacturer Wise)','Laporan Stok (Berdasarkan Produsen)'),(418,'stock_report_product_wise','Stock Report (Medicine Wise)','Laporan Stok (Medicine Wise)'),(419,'select_manufacturer','Select Manufacturer','Pilih Produsen'),(420,'select_product','Select Medicine','Pilih Obat'),(421,'phone','Phone','Telepon'),(422,'in_quantity','In Quantity','Dalam Jumlah'),(423,'out_quantity','Sold QTY','Jumlah Terjual'),(424,'in_taka','In Taka','Di Taka'),(425,'out_taka','Out Taka','Keluar Taka'),(426,'data_synchronizer','Data Synchronizer','Sinkronisasi Data'),(427,'synchronize','Synchronize','Sinkronkan'),(428,'backup_restore','Backup And Restore','Pencadangan dan Pemulihan'),(429,'synchronizer_setting','Synchronizer Setting','Pengaturan Sinkronisasi'),(430,'backup_and_restore','Backup And Restore','Pencadangan dan Pemulihan'),(431,'hostname','Host Name','Nama Host'),(432,'username','User Name','Nama belakang'),(433,'ftp_port','FTP Port','Port FTP'),(434,'ftp_debug','FTP Debug','Debug FTP'),(435,'project_root','Project Root','Akar Proyek'),(436,'internet_connection','Internet connection','Koneksi internet'),(437,'ok','Ok','Oke'),(438,'not_available','Not available','Tidak tersedia'),(439,'outgoing_file','Outgoing File','Berkas Keluar'),(440,'available','Available','Tersedia'),(441,'incoming_file','Incoming file','Berkas masuk'),(442,'data_upload_to_server','Data upload to server','Unggahan data ke server'),(443,'download_data_from_server','Download data from server','Unduh data dari server'),(444,'data_import_to_database','Data import to database','Impor data ke basis data'),(445,'please_wait','Please Wait','Harap tunggu'),(446,'ooops_something_went_wrong','Ooops something went wrong','Ups, terjadi kesalahan.'),(447,'file_information','File Information','Informasi Berkas'),(448,'size','Size','Ukuran'),(449,'backup_date','Backup date','Tanggal cadangan'),(450,'backup_now','Backup Now','Cadangkan Sekarang'),(451,'are_you_sure','Are you sure ?','Apa kamu yakin ?'),(452,'download','Downlaod','Unduh'),(453,'database_backup','Database Backup','Pencadangan Basis Data'),(454,'backup_successfully','Backup Successfully','Pencadangan Berhasil'),(455,'please_try_again','Please Try Again','Silakan coba lagi.'),(456,'restore_successfully','Restore successfully','Pemulihan berhasil'),(457,'download_successfully','Download Successfully','Unduhan Berhasil'),(458,'delete_successfully','Delete Successfully','Penghapusan Berhasil'),(459,'ftp_setting','FTP Setting','Pengaturan FTP'),(460,'save_successfully','Save successfully','Penyimpanan berhasil'),(461,'upload_successfully','Upload successfully.','Unggahan berhasil.'),(462,'unable_to_upload_file_please_check_configuration','unable to upload file please check configuration.','Tidak dapat mengunggah file, harap periksa konfigurasi.'),(463,'please_configure_synchronizer_settings','Please Configure Synchronizer Settings','Harap Konfigurasi Pengaturan Sinkronisasi'),(464,'unable_to_download_file_please_check_configuration','Unable To Download File,Please Check Configuration.','Tidak dapat mengunduh file, harap periksa konfigurasi.'),(465,'data_import_first','Data Import First','Impor Data Terlebih Dahulu'),(466,'data_import_successfully','Data Import Successfully','Impor Data Berhasil'),(467,'unable_to_import_data_please_check_config_or_sql_file','Unable to import data please check config or sql file.','Tidak dapat mengimpor data, harap periksa file konfigurasi atau SQL.'),(468,'restore_now','Restore Now','Pulihkan Sekarang'),(469,'out_of_stock','Out Of Stock','Stok Habis'),(470,'others','Others','Yang lain'),(471,'shelf','Shelf','Rak'),(472,'discount_type','Discount Type','Jenis Diskon'),(473,'discount_percentage','Discount','Diskon'),(474,'fixed_dis','Fixed Dis','Dis yang Diperbaiki'),(475,'full_paid','Full Paid','Dibayar Penuh'),(476,'available_qnty','Ava.Qty','Jumlah yang Tersedia'),(477,'stock_ctn','Stock/Qnt','Stok/Jumlah'),(478,'sale_price','Sale Price','Harga penjualan'),(479,'manufacturer_rate','Distributor  Rate','Tarif Distributor'),(480,'please_upload_image_type','Sorry!!! Please Upload jpg,jpeg,png,gif typeimage','Maaf!!! Silakan unggah gambar berformat jpg, jpeg, png, gif.'),(481,'ml','Milli liter(ml)','Mililiter (ml)'),(482,'mg','Milli Gram(mg)','Miligram (mg)'),(483,'you_can_not_buy_greater_than_available_qnty','You can not sale more than available quantity ! please purchase this Product','Anda tidak dapat menjual melebihi jumlah yang tersedia! Silakan beli produk ini.'),(484,'due_amount','Due Amount','Jumlah yang Harus Dibayar'),(485,'return_invoice','Return Invoice','Faktur Pengembalian'),(486,'sold_qty','Sold Qty','Jumlah Terjual'),(487,'ret_quantity','Return QTY','Jumlah Pengembalian'),(488,'deduction','Deduction','Deduksi'),(489,'return','Return','Pengembalian'),(490,'note','Return Reasone','Alasan Pengembalian'),(491,'usablilties','Return Usability','Kemudahan Penggunaan Pengembalian'),(492,'adjs_with_stck','Adjust With Stock','Sesuaikan dengan Stok'),(493,'return_to_manufacturer','Return To Manufacturer','Pengembalian ke Produsen'),(494,'wastage','Wastage','Pemborosan'),(495,'to_deduction','Total Deduction','Potongan Total'),(496,'nt_return','Net Return','Keuntungan Bersih'),(497,'return_id','Return Id','ID Pengembalian'),(498,'return_details','Return Details','Detail Pengembalian'),(499,'add_return','Add Return','Tambahkan Pengembalian'),(500,'return_list','Return List','Daftar Pengembalian'),(501,'stock_return_list','Stock Return List','Daftar Pengembalian Stok'),(502,'wastage_return_list','Wastage Return List','Daftar Pengembalian Limbah'),(503,'check_return','Check Return','Cek Pengembalian'),(504,'quantity_must_be_fillup','Return Quantity Must be Fill Up','Jumlah Pengembalian Harus Diisi Penuh'),(505,'expeire_date','Expiry  date','Tanggal kedaluwarsa'),(506,'batch_id','Batch ID','ID Batch'),(507,'manufacturer_return_list','Distributor  Return List','Daftar Pengembalian Distributor'),(508,'c_r_slist','Customer Return List','Daftar Pengembalian Pelanggan'),(509,'manufacturer_return','Distributor  Return','Pengembalian Distributor'),(510,'wastage_list','Wastage List','Daftar Pemborosan'),(511,'in_qnty','In Quantity','Dalam Jumlah'),(512,'out_qnty','Sold QTY','Jumlah Terjual'),(513,'stock_sale','Stock Sell Price','Harga Jual Saham'),(514,'add_product_csv','Import Medicine (CSV)','Impor Obat (CSV)'),(515,'purchase_id','Purchase ID','ID Pembelian'),(516,'add_payment','Add Payment','Tambahkan Pembayaran'),(517,'add_new_payment','Add new Payment','Tambahkan Pembayaran Baru'),(518,'transaction','Transaction','Transaksi'),(519,'manage_transaction','Manage Transaction','Kelola Transaksi'),(520,'choose_transaction','Choose Transaction','Pilih Transaksi'),(521,'receipt','Receipt','Kuitansi'),(522,'payment','Payment','Pembayaran'),(523,'transaction_categry','Transaction Category','Kategori Transaksi'),(524,'transaction_mood','Transaction Mood','Suasana Transaksi'),(525,'payment_amount','Payment Amount','Jumlah Pembayaran'),(526,'receipt_amount','Receipt Amount','Jumlah Tanda Terima'),(527,'daily_summary','Daily Summary','Ringkasan Harian'),(528,'daily_cash_flow','Daily  Cashflow','Arus Kas Harian'),(529,'custom_report','Custom Report','Laporan Khusus'),(530,'root_account','Root Account','Akun Utama'),(531,'office','Office','Kantor'),(532,'loan','Loan','Meminjamkan'),(533,'successfully_saved','Successfully Saved','Berhasil Disimpan'),(534,'bank','Bank','Bank'),(535,'bank_transaction','Bank Transaction','Transaksi Bank'),(536,'office_loan','Office Loan','Pinjaman Kantor'),(537,'add_person','Add Person','Tambahkan Orang'),(538,'manage_loan','Manage Person','Mengelola Orang'),(539,'add_loan','Add Loan','Tambah Pinjaman'),(540,'ac_name','Account Name','Nama Akun'),(541,'ac_no','Account No','Nomor Rekening'),(542,'branch','Branch','Cabang'),(543,'signature_pic','Signature','Tanda tangan'),(544,'withdraw_deposite_id','Withdraw Deposit ID','ID Setoran Penarikan'),(545,'select_report','Select Report','Pilih Laporan'),(546,'per_qty','Purchase Qty','Jumlah Pembelian'),(547,'stock_report_batch_wise','Stock Report(Batch Wise)','Laporan Stok (Per Batch)'),(548,'box','Box','Kotak'),(549,'gram','Gram','Gram'),(550,'profit_report_manufacturer_wise','Profit/Loss Report(Distributor)','Laporan Laba/Rugi (Distributor)'),(551,'calculate','Calculate','Menghitung'),(552,'profit_report_product_wise','Profit/Loss  Report Product Wise','Laporan Laba/Rugi Berdasarkan Produk'),(553,'view_report','View Report','Lihat Laporan'),(554,'report_for','Report For','Laporan Untuk'),(555,'total_sale_qty','Total Sale QTY','Jumlah Penjualan Total'),(556,'total_purchase_pric','Total purchase Price','Harga pembelian total'),(557,'total_sale','Total Sale','Total Penjualan'),(558,'net_profit','Net Profit','Laba Bersih'),(559,'loss','Loss','Kehilangan'),(560,'product_type','Medicine Type','Jenis Obat'),(561,'add_type','Add Medicine Type','Tambahkan Jenis Obat'),(562,'add_new_type','Add New Medicine  Type','Tambahkan Jenis Obat Baru'),(563,'type','Type','Jenis'),(564,'type_name','Type Name','Nama Tipe'),(565,'manage_type','Manage Medicine Type','Kelola Jenis Obat'),(566,'type_id','Type Id','Tipe ID'),(567,'type_edit','Edit Type','Edit Tipe'),(568,'profitloss','profit/Loss','untung/rugi'),(569,'manufacturer_wise','Distributor Wise','Distributor Wise'),(570,'product_wise','Medicine Wise','Bijak Pengobatan'),(571,'medicine_info','Medicine Information','Informasi Obat'),(572,'choose_another_invno','Choose Another Invoice No !!','Pilih Nomor Faktur Lain !!'),(573,'return_manufacturers','Return Manufacturers','Pengembalian Produsen'),(574,'return_manufacturer','Return Manufacturers','Pengembalian Produsen'),(575,'please_input_correct_invoice_no','Please Input Correct Invoice No','Harap masukkan Nomor Faktur yang benar.'),(576,'stock_purchase_price','Stock Purchase Price','Harga Pembelian Saham'),(577,'manufacturer_returns','Distributor  Return','Pengembalian Distributor'),(578,'invoice_discount','Invoice Discount','Diskon Faktur'),(579,'qty','Qty','Jumlah'),(580,'discounts','Discount','Diskon'),(581,'sub_total','Sub Total','Subtotal'),(582,'paid','Paid','Dibayar'),(583,'change','Change','Mengubah'),(584,'purchase_price','Purchase Price','Harga Pembelian'),(585,'expiry','Expiry','Kadaluarsa'),(586,'batch','Batch','Kelompok'),(587,'role_permission','Role Permission','Izin Peran'),(588,'user_assign_role','Assign  User Role','Tetapkan Peran Pengguna'),(589,'permission','Permission','Izin'),(590,'personal_loan','Personal Loan','Pinjaman Pribadi'),(591,'role_name','Role Name','Nama Peran'),(592,'create','Create','Membuat'),(593,'read','Read','Membaca'),(594,'add_role','Add Role','Tambahkan Peran'),(595,'You do not have permission to access. Please contact with administrator.','You do not have permission to access. Please contact with administrator.','Anda tidak memiliki izin akses. Silakan hubungi administrator.'),(596,'role_permission_added_successfully','Role Permission Added successfully.','Izin peran berhasil ditambahkan.'),(597,'role_list','Role List','Daftar Peran'),(598,'role_permission_updated_successfully','Role Permission Updated Successfully.','Izin Peran Berhasil Diperbarui.'),(599,'add_phrase','Add Phrase','Tambahkan Frasa'),(600,'language_home','Language Home','Beranda Bahasa'),(601,'phrase_edit','Phrase Edit','Suntingan Frasa'),(602,'no_role_selected','No Role Selected','Tidak Ada Peran yang Dipilih'),(603,'category_added_successfully','Category added successfully','Kategori berhasil ditambahkan.'),(604,'category_already_exist','Category already exist','Kategori sudah ada.'),(605,'select_manufacturer','Select Manufacturer','Pilih Produsen'),(607,'select_tax','Select Tax','Pilih Pajak'),(608,'must_input_numbers','Must input numbers','Harus memasukkan angka'),(609,'please_check_your_price','Please Check Your Price','Silakan Periksa Harga Anda'),(610,'your_profit_is','Your Profit is','Keuntungan Anda adalah'),(611,'failed','Failed','Gagal'),(612,'you_have_reached_the_limit_of_adding','You have reached the limit of adding','Anda telah mencapai batas penambahan.'),(613,'inputs','inputs','masukan'),(614,'expiry_date_should_be_greater_than_puchase_date','Expiry Date should be greater than Puchase Date','Tanggal Kedaluwarsa harus lebih besar dari Tanggal Pembelian.'),(615,'expiry_date_should_be_greater_than_puchase_date','Expiry Date should be greater than Puchase Date','Tanggal Kedaluwarsa harus lebih besar dari Tanggal Pembelian.'),(616,'product_name','Medicine Name','Nama Obat'),(617,'total_quantity','Total Quantity','Jumlah Total'),(618,'rates','Rate','Kecepatan'),(619,'total_amount','Total Amount','Jumlah Total'),(621,'receipt_detail','Receipt Detail','Rincian Tanda Terima'),(622,'amount','Amount','Jumlah'),(623,'save_and_add_another_one','Save and add another one','Simpan dan tambahkan yang lain'),(624,'checque_number','Checque Number','Nomor Cek'),(625,'edit_receipt','Edit Receipt','Edit Tanda Terima'),(626,'receipt_list','Receipt List','Daftar Tanda Terima'),(627,'search_by_customer_name','Search By Customer Name','Cari Berdasarkan Nama Pelanggan'),(628,'actions','Actions','Tindakan'),(629,'no_data_found','No Data Found','Tidak ada data yang ditemukan.'),(630,'edit','Edit','Edit'),(631,'product_not_found','Medicine  not found','Obat tidak ditemukan'),(632,'request_failed_please_check_your_code_and_try_again','Request Failed, Please check your code and try again','Permintaan gagal, harap periksa kode Anda dan coba lagi.'),(633,'You_can_not_return_more_than_sold_quantity','You Can Not Return More than Sold quantity','Anda tidak dapat mengembalikan barang melebihi jumlah yang terjual.'),(634,'you_can_not_return_less_than_1','You Can Not Return Less than 1','Anda tidak dapat mengembalikan kurang dari 1'),(635,'transection_details','Transection Details','Rincian Transeksi'),(636,'transection_details_datewise','Transection  Details Datewise','Rincian Transaksi Berdasarkan Tanggal'),(637,'transection_id','Transactions ID','ID Transaksi'),(638,'select_option','Select Option','Pilih Opsi'),(639,'loan_list','Loan List','Daftar Pinjaman'),(640,'todays_details','Todays Details','Rincian Hari Ini'),(641,'transaction_details','Transaction Details','Rincian Transaksi'),(642,'person_id','Person ID','ID Orang'),(643,'total_transection','Total Transection','Transeksi Total'),(644,'transaction_id','Transaction ID','ID Transaksi'),(645,'transection_report','Transection Report','Laporan Transeksi'),(646,'add_transection','Add Transection','Tambahkan Transeksi'),(647,'manage_transection','Manage Transection','Kelola Transeksi'),(648,'select_id','Select ID','Pilih ID'),(649,'choose_transection','Choose Transection','Pilih Transeksi'),(650,'update_transection','Update Transection','Pembaruan Transkrip'),(651,'manufacturer_all','Distributor All','Distributor Semua'),(652,'select_all','Select All','Pilih Semua'),(653,'all','All','Semua'),(654,'max_rate','Max Rate','Tarif Maksimum'),(655,'min_rate','Min Rate','Tarif Minimum'),(656,'average_rate','Average Rate','Tarif Rata-Rata'),(657,'date_expired_please_choose_another.','Date Expired!! Please Choose another','Tanggal kedaluwarsa telah berakhir!! Silakan pilih yang lain'),(658,'your_medicine_is_date_expiry_Please_choose_another','Your Medicine is Date Expiry !! Please Choose another','Obat Anda sudah kedaluwarsa!! Silakan pilih obat lain.'),(659,'meno','MEMO','MEMO'),(660,'out_of_stock_and_date_expired_medicine','Out of Stock and Date Expired Medicine','Obat Habis Stok dan Kedaluwarsa'),(661,'edit_profile','Edit Profile','Edit Profil'),(662,'deposit_detail','Deposit detail','Rincian setoran'),(663,'new_deposit','New Deposit','Setoran Baru'),(664,'edit_deposit','Edit Deposit','Edit Setoran'),(665,'select_customer','Select Customer','Pilih Pelanggan'),(666,'draw','Draw','Menggambar'),(667,'deposit','Deposit','Deposito'),(668,'select_type','Select Type','Pilih Jenis'),(669,'transaction_type','Transaction Type','Jenis Transaksi'),(670,'cash','Cash','Uang tunai'),(671,'select_bank','Select Bank','Pilih Bank'),(672,'drawing','Drawing','Menggambar'),(673,'expenses','Expenses','Pengeluaran'),(674,'banking','Banking','Perbankan'),(675,'daily_closing','Daily Closing','Penutupan Harian'),(676,'title','Title','Judul'),(677,'error_get_data_from_ajax','Error get data from ajax','Terjadi kesalahan saat mengambil data dari ajax.'),(678,'toggle_navigation','Toggle Navigation','Alihkan Navigasi'),(679,'this_product_not_found','This Medicine  Not Found !','Obat ini tidak ditemukan!'),(680,'search_by_date_from','Search By Date: From','Cari Berdasarkan Tanggal: Dari'),(681,'manufacturer_sales_report','Distributor Sales Report','Laporan Penjualan Distributor'),(682,'transection','Transection','Penampang lintang'),(683,'transection_mood','Transection Mood','Suasana Transeksi'),(684,'transection_categry','Transection Categry','Kategori Transeksi'),(685,'export_csv','Export CSV','Ekspor CSV'),(686,'select manufacturer','Select Manufacturer','Pilih Produsen'),(687,'customer_return','Customer Return','Pengembalian Pelanggan'),(688,'return_form','Return Form','Formulir Pengembalian'),(689,'data_not_found','Data Not Found','Data Tidak Ditemukan'),(690,'export_csv','Export CSV','Ekspor CSV'),(691,'manage_person','Manage Person','Mengelola Orang'),(692,'backup','Back Up','Cadangan'),(693,'total_balance','Total Balance','Saldo Total'),(694,'product_id_model_manufacturer_id_can_not_null','Medicine Id & Medicine Type & Distributor Id Can not be Blank','ID Obat, Jenis Obat, dan ID Distributor tidak boleh kosong.'),(695,'product_name_can_not_be_null','Medicine  Name can Not be Blank','Nama Obat Tidak Boleh Kosong'),(696,'product_model_can_not_be_null','Medicine  Model Can Not be Blank','Model Kedokteran Tidak Boleh Kosong'),(697,'sms','SMS','SMS'),(698,'sms_configure','Sms Configuration','Konfigurasi SMS'),(699,'url','Url','URL'),(700,'sender_id','Sender ID','ID Pengirim'),(701,'api_key','Api Key','Kunci API'),(702,'barcode_or_qrcode','Barcode Or QRcode','Kode Batang atau Kode QR'),(703,'currency_name','Currency Name','Nama Mata Uang'),(704,'add_currency','Add Currency','Tambahkan Mata Uang'),(705,'currency_icon','Currency Icon','Ikon Mata Uang'),(706,'currency_list','Currency List','Daftar Mata Uang'),(707,'import','Import','Impor'),(708,'c_o_a','Chart Of Account','Bagan Akun'),(709,'supplier_payment','Supplier Payment','Pembayaran Supplier'),(710,'customer_receive','Customer Receive','Pelanggan Menerima'),(711,'debit_voucher','Debit Voucher','Voucher Debit'),(712,'credit_voucher','Credit voucher','Voucher kredit'),(713,'voucher_approval','Voucher Approval','Persetujuan Voucher'),(714,'contra_voucher','Contra Voucher','Voucher Kontra'),(715,'journal_voucher','Journal Voucher','Voucher Jurnal'),(716,'voucher_report','Voucher Report','Laporan Voucher'),(717,'cash_book','Cash Book','Buku Kas'),(718,'inventory_ledger','Inventory Ledger','Buku Besar Persediaan'),(719,'bank_book','Bank Book','Buku Bank'),(720,'general_ledger','General Ledger','Jurnal umum'),(721,'trial_balance','Trial Balance','Neraca saldo'),(722,'profit_loss_report','Profit Loss Report','Laporan Laba Rugi'),(723,'cash_flow','Cash Flow','Arus Kas'),(724,'coa_print','COA Print','Cetak COA'),(725,'manufacturer_payment','Distributor Payment','Pembayaran Distributor'),(726,'add_more','Add More','Tambahkan lagi'),(727,'code','Code','Kode'),(728,'remark','Transaction Details','Rincian Transaksi'),(729,'voucher_no','Voucher NO','Nomor Voucher'),(730,'accounts_tree_view','Accounts Tree view','Tampilan Pohon Akun'),(731,'find','Find','Menemukan'),(732,'voucher_type','Voucher Type','Jenis Voucher'),(733,'particulars','Particulars','Rincian'),(734,'cash_flow_statement','Cash Flow Statement','Laporan Arus Kas'),(735,'amount_in_dollar','Amount In Dollar','Jumlah dalam Dolar'),(736,'opening_cash_and_equivalent','Opening Cash and Equivalent','Saldo Kas Awal dan Setara'),(737,'with_details','With Details','Dengan rincian'),(738,'transaction_head','Transaction Head','Kepala Transaksi'),(739,'gl_head','General Ledger Head','Kepala Buku Besar Umum'),(740,'no_report','No Report','Tidak ada laporan.'),(741,'pre_balance','Pre Balance','Saldo Awal'),(742,'current_balance','Current Balance','Saldo Saat Ini'),(743,'from_date','From Date','Dari Tanggal'),(744,'to_date','To Date','Hingga saat ini'),(745,'profit_loss','Profit Loss Statement','Laporan Laba Rugi'),(746,'add_expense_item','Add Expense Item','Tambahkan Item Pengeluaran'),(747,'manage_expense_item','Manage Expense Item','Kelola Item Pengeluaran'),(748,'add_expense','Add Expense','Tambahkan Biaya'),(749,'manage_expense','Manage Expense','Kelola Pengeluaran'),(750,'expense_statement','Expense Statement','Laporan Pengeluaran'),(751,'expense_type','Expense Type','Jenis Pengeluaran'),(752,'expense_item_name','Expense Item Name','Nama Item Pengeluaran'),(753,'opening_balance','Opening Balance','Saldo Awal'),(754,'tax_settings','Tax Settings','Pengaturan Pajak'),(755,'add_incometax','Add Income Tax','Tambahkan Pajak Penghasilan'),(756,'manage_income_tax','Manage Income tax','Mengelola pajak penghasilan'),(757,'tax_report','Tax Report','Laporan Pajak'),(758,'invoice_wise_tax_report','Invoice Wise Tax Report','Laporan Pajak Berdasarkan Transaksi'),(759,'number_of_tax','Number of Tax','Jumlah Pajak'),(760,'default_value','Default Value','Nilai Default'),(761,'reg_no','Registration No','Nomor Registrasi'),(762,'tax_name','Tax Name','Nama Pajak'),(763,'service_id','Service Id','ID Layanan'),(764,'service','Service','Melayani'),(765,'add_service','Add Service','Tambahkan Layanan'),(766,'manage_service','Manage Service','Kelola Layanan'),(767,'service_invoice','Service Invoice','Transaksi Layanan'),(768,'manage_service_invoice','Manage Service Invoice','Kelola Transaksi Layanan'),(769,'service_name','Service Name','Nama Layanan'),(770,'charge','Charge','Mengenakan biaya'),(771,'add','Add','Menambahkan'),(772,'previous','Previous','Sebelumnya'),(773,'net_total','Net Total','Jumlah Bersih'),(774,'hanging_over','Estimated Time Of Departure','Perkiraan Waktu Keberangkatan'),(775,'service_discount','Service Discount','Diskon Layanan'),(776,'hrm','HRM','SDM'),(777,'add_designation','Add Designation','Tambahkan Jabatan'),(778,'manage_designation','Manage Designation','Kelola Penunjukan'),(779,'add_employee','Add Employee','Tambahkan Karyawan'),(780,'manage_employee','Manage Employee','Mengelola Karyawan'),(781,'attendance','Attendance','Kehadiran'),(782,'add_attendance','Add Attendance','Tambahkan Kehadiran'),(783,'manage_attendance','Manage Attendance','Kelola Kehadiran'),(784,'attendance_report','Attendance Report','Laporan Kehadiran'),(785,'payroll','Payroll','Daftar gaji'),(786,'add_benefits','Add Benefits','Tambahkan Manfaat'),(787,'manage_benefits','Manage Benefits','Kelola Manfaat'),(788,'add_salary_setup','Add Salary Setup','Tambahkan Pengaturan Gaji'),(789,'manage_salary_setup','Manage Salary Setup','Kelola Pengaturan Gaji'),(790,'salary_generate','Salary Generate','Gaji yang Dihasilkan'),(791,'manage_salary_generate','Manage Salary Generate','Kelola Gaji Hasilkan'),(792,'salary_payment','Salary Payment','Pembayaran Gaji'),(793,'designation','Designation','Penamaan'),(794,'rate_type','Rate Type','Jenis Tarif'),(795,'hour_rate_or_salary','Hourly Rate/Salary','Tarif/Gaji Per Jam'),(796,'blood_group','Blood Group','Golongan Darah'),(797,'address_line_1','Address Line 1','Baris Alamat 1'),(798,'address_line_2','Address Line 2','Baris Alamat 2'),(799,'picture','Picture','Gambar'),(800,'country','Country','Negara'),(801,'city','City','Kota'),(802,'zip','Zip code','Kode pos'),(803,'single_checkin','Single Check In','Check-in Tunggal'),(804,'bulk_checkin','Bulk Check In','Check-in Massal'),(805,'checkin','Check In','Check In'),(806,'employee_name','Employee Name','Nama Karyawan'),(807,'check_in','Check In','Check In'),(808,'checkout','Check Out','Memeriksa'),(809,'confirm_clock','Confirm Clock','Konfirmasi Jam'),(810,'stay','Stay','Tinggal'),(811,'download_sample_file','Download Sample File','Unduh File Contoh'),(812,'employee','Employee','Karyawan'),(813,'sign_in','Check In','Check In'),(814,'sign_out','Check  Out','Memeriksa'),(815,'staytime','Stay Time','Waktu Menginap'),(816,'benefits_list','Benefit List','Daftar Manfaat'),(817,'benefits','Benefits','Manfaat'),(818,'benefit_type','Benefit Type','Jenis Manfaat'),(819,'salary_benefits','Salary Benefits','Tunjangan Gaji'),(820,'salary_benefits_type','Salary Benefits Type','Jenis Tunjangan Gaji'),(821,'hourly','Hourly','Per jam'),(822,'salary','Salary','Gaji'),(823,'timezone','Time Zone','Zona Waktu'),(824,'request','Request','Meminta'),(825,'datewise_report','Date Wise Report','Laporan Berdasarkan Tanggal'),(826,'work_hour','Work Hours','Jam Kerja'),(827,'employee_wise_report','Employee Wise Report','Laporan Berdasarkan Karyawan'),(828,'date_in_time_report','In Time Report','Laporan Tepat Waktu'),(829,'successfully_checkout','Successfully Checked Out','Berhasil melakukan pembayaran'),(830,'setup_tax','Setup Tax','Pajak Pengaturan'),(831,'start_amount','Start Amount','Jumlah Awal'),(832,'end_amount','End Amount','Jumlah Akhir'),(833,'tax_rate','Tax Rate','Tarif Pajak'),(834,'setup','Setup','Pengaturan'),(835,'income_tax_updateform','Income Tax Update Form','Formulir Pembaruan Pajak Penghasilan'),(836,'salary_type','Salary Type','Jenis Gaji'),(837,'addition','Addition','Tambahan'),(838,'gross_salary','Gross Salary','Gaji Kotor'),(839,'set','Set','Mengatur'),(840,'salary_month','Salary Month','Bulan Gaji'),(841,'generate','Generate','Menghasilkan'),(842,'total_salary','Total Salary','Total Gaji'),(843,'total_working_minutes','Total Working Hours','Total Jam Kerja'),(844,'working_period','Total Working Days','Jumlah Hari Kerja'),(845,'paid_by','Paid By','Dibayar Oleh'),(846,'pay_now','Pay Now ?','Bayar Sekarang?'),(847,'confirm','Confirm','Mengonfirmasi'),(848,'generate_by','Generate By','Dihasilkan Oleh'),(849,'gui_pos','GUI POS','GUI POS'),(850,'add_fixed_assets','Add Fixed Assets','Tambahkan Aset Tetap'),(851,'fixed_assets_list','Fixed Asset List','Daftar Aset Tetap'),(852,'fixed_assets_purchase','Purchase Fixed Assets','Pembelian Aset Tetap'),(853,'fixed_assets_purchase_manage','Fixed Assets Purchase List','Daftar Pembelian Aset Tetap'),(854,'fixed_assets','Fixed Assets','Aset Tetap'),(855,'item_code','Item code','Kode barang'),(856,'item_name','Item Name','Nama Barang'),(857,'opening_assets','Assets Qty','Jumlah Aset'),(858,'edit_fixed_asset','Edit Fixed Assets','Edit Aset Tetap'),(859,'save_change','Save Change','Simpan Perubahan'),(860,'in_word','In Word','Dalam kata-kata'),(861,'purchase_pad_print','Purchase Pad Print','Beli Pad Print'),(862,'fixed_assets_purchase_details','Fixed Assets Purchase Details','Rincian Pembelian Aset Tetap'),(863,'manage_language','Manage Language','Kelola Bahasa'),(864,'person_edit','Person Edit','Pengeditan Orang'),(865,'person_ledger','Person Ledger','Buku Besar Pribadi'),(866,'medicine_name','Medicine Name','Nama Obat'),(867,'unit_list','Unit List','Daftar Unit'),(868,'add_unit','Add Unit','Tambahkan Unit'),(869,'edit_unit','Edit Unit','Unit Pengeditan'),(870,'unit_name','Unit Name','Nama Unit'),(871,'unit_not_selected','Unit did not Selected','Unit tidak terpilih'),(872,'supplier','Supplier','Supplier'),(873,'add_supplier','Add Supplier','Tambahkan Supplier'),(874,'manage_supplier','Manage Supplier','Kelola Supplier'),(875,'supplier_ledger','Supplier Ledger','Buku Besar Supplier'),(876,'supplier_sales_details','Supplier Sales Details','Rincian Penjualan Supplier'),(877,'purchase_detail','Purchase details','Detail pembelian'),(878,'purchase_information','Purchase Information','Informasi Pembelian'),(879,'account_head','Account Head','Kepala Akun'),(880,'transaction_date','Transaction Date','Tanggal Transaksi'),(881,'approved','Approve','Menyetujui'),(882,'date_wise_report','Date Wise Report','Laporan Berdasarkan Tanggal'),(883,'time_wise_report','Time Wise Report','Laporan Berdasarkan Waktu'),(884,'report_date','Report Date','Tanggal Laporan'),(885,'s_time','Start Time','Waktu Mulai'),(886,'e_time','End Time','Waktu Berakhir'),(887,'basic','Basic','Dasar'),(888,'supplier_name','Supplier Name','Nama Supplier'),(889,'supplier_mobile','Supplier Mobile','Supplier Seluler'),(890,'supplier_address','Supplier Address','Alamat Supplier'),(891,'supplier_details','Supplier Details','Detail Supplier'),(892,'select_supplier','Select Supplier','Pilih Supplier'),(893,'accounts_report','Accounts Report','Laporan Akun'),(894,'account_code','Account Code','Kode Akun'),(895,'human_resource_management','Human Resource','Sumber Daya Manusia'),(896,'menu_name','Menu Name','Nama Menu'),(897,'head_of_account','Account Head','Kepala Akun'),(898,'successfully_approved','Successfully Approved','Berhasil Disetujui'),(899,'supplier_edit','Supplier Edit','Pengeditan Supplier'),(900,'supplier_id','Supplier ID','ID Supplier'),(901,'strength','Strength','Kekuatan'),(902,'out_of_date','Out Of Date','Kedaluwarsa'),(903,'dis','Dis','Dis'),(904,'date_expired_please_choose_another','Date Expire Please Choose another','Tanggal Kedaluwarsa Silakan Pilih yang Lain'),(905,'expired','Expired','Kedaluwarsa'),(906,'cash_adjustment','Cash Adjustment','Penyesuaian Tunai'),(907,'adjustment_type','Adjustment Type','Jenis Penyesuaian'),(908,'cash_payment','Cash Payment','Pembayaran Tunai'),(909,'bank_payment','Bank Payment','Pembayaran Bank'),(910,'yes','Yes','Ya'),(911,'no','No','TIDAK'),(912,'credit_account_head','Credit Account Head','Kepala Akun Kredit'),(913,'general_ledger_of','General Ledger Of','Buku Besar Umum'),(914,'debit_account_head','Debit Account Head','Kepala Akun Debit'),(915,'update_successfully','Successfully Updated','Pembaruan Berhasil'),(916,'statement_of_comprehensive_income','Statement of Comprehensive Income','Laporan Laba Rugi Komprehensif'),(917,'deduct','Deduct','Mengurangi'),(918,'payslip','Payslip','Slip gaji'),(919,'salary_slip','Salary Slip','Slip Gaji'),(920,'salary_date','Salary Date','Tanggal Gaji'),(921,'earnings','Earnings','Pendapatan'),(922,'basic_salary','Basic Salary','Gaji Pokok'),(923,'total_addition','Total Addition','Jumlah Penambahan'),(924,'total_deduction','Total Deduction','Potongan Total'),(925,'net_salary','Net Salary','Gaji Bersih'),(926,'ref_number','Reference No','Nomor Referensi'),(927,'employee_signature','Employee Signature','Tanda Tangan Karyawan'),(928,'authorized_signature','Authorized Signature','Tanda Tangan Resmi'),(929,'chairman','Chairman','Ketua'),(930,'bank_ledger','Bank Ledger','Buku Besar Bank'),(931,'api_secret','Api Secret','Rahasia API'),(932,'service_csv_upload','Service Csv Upload','Layanan Unggah CSV'),(933,'shipping_cost','Shipping Cost','Biaya Pengiriman'),(934,'customer_advance','Customer Advance','Uang Muka Pelanggan'),(935,'customer_csv_upload','Customer CSV Upload','Unggahan CSV Pelanggan'),(936,'contact','Contact','Kontak'),(937,'fax','Fax','Fax'),(938,'state','State','Negara'),(939,'address1','Address1','Alamat1'),(940,'address2','Address2','Alamat2'),(941,'manufacturer_advance','Distributor Advance','Uang Muka Distributor'),(942,'csv_upload_manufacturer','CSV Upload Distributor','Distributor Unggahan CSV'),(943,'restore','Restore','Memulihkan'),(944,'advance_type','Advance Type','Tipe Lanjutan'),(945,'receive','Receive','Menerima'),(946,'note_name','Notes','Catatan'),(947,'pcs','PCS','PCS'),(948,'do_you_want_to_print','Do You Want To Print ?','Apakah Anda ingin mencetak?'),(949,'the_salary_of',NULL,'BATAL'),(950,'already_generated','Already Generated','Sudah Dihasilkan'),(951,'successfully_generated','Successfully Generated','Berhasil Dibuat'),(952,'service_edit','Service Edit','Layanan Edit'),(953,'signature','Signature','Tanda tangan'),(954,'manage','Manage','Mengelola'),(955,'income_expense_statement','Income Expense Statement','Laporan Pendapatan dan Pengeluaran'),(956,'cash_received','Cash Received','Terima kas'),(957,'bank_received','Bank Received','Bank Menerima'),(958,'total_due','Total Due','Jumlah yang Harus Dibayar'),(959,'total_service','Total Service','Layanan Lengkap'),(960,'type_not_selected','Type did not Selected','Tipe tidak dipilih'),(961,'stock_edit','Stock Edit','Pengeditan Stok'),(962,'add_payment_type','Add Payment Type','Tambah Jenis Pembayaran'),(963,'payment_type_list','Payment Type List','Daftar Jenis Pembayaran'),(964,'edit_payment_type','Edit Payment Type','Ubah Jenis Pembayaran'),(965,'payment_type_name','Payment Type Name','Nama Jenis Pembayaran'),(966,'master_data','Master Data','Master Data'),(967,'receipt_header_footer','Receipt Header Footer','Header Footer Struk'),(968,'receipt_header','Receipt Header','Header Struk'),(969,'receipt_footer','Receipt Footer','Footer Struk'),(970,'pbf','PBF','PBF'),(971,'is_pbf','PBF (Pedagang Besar Farmasi)','PBF (Pedagang Besar Farmasi)'),(972,'near_expiry','Near Expiry Medicine','Obat Mendekati Kedaluwarsa'),(973,'near_expiry_list','Near Expiry Medicine List','Daftar Obat Mendekati Kedaluwarsa'),(974,'expiry_alert_months','Expiry Alert (Months)','Ambang Notifikasi Kedaluwarsa (Bulan)'),(975,'expiry_alert_setting','Expiry Alert Setting','Ambang Notifikasi Kedaluwarsa'),(976,'day','day','hari'),(977,'days','days','hari'),(978,'week','week','minggu'),(979,'month','month','bulan'),(980,'days_left','Time Left','Sisa Waktu'),(981,'urgency','Status','Status Urgensi');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturer_information`
--

DROP TABLE IF EXISTS `manufacturer_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `is_pbf` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=PBF(Ya),0=Tidak',
  PRIMARY KEY (`manufacturer_id`),
  KEY `manufacturer_id` (`manufacturer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturer_information`
--

LOCK TABLES `manufacturer_information` WRITE;
/*!40000 ALTER TABLE `manufacturer_information` DISABLE KEYS */;
INSERT INTO `manufacturer_information` VALUES (1,'Kimia Farma','','','08892970567','','','','08892970567','','','','','Indonesia','',1,1),(2,'PT Teknologi Medika Pratama ','Jl. Tugu Raya RT.10/RW.10 Kel Tugu, Kec Cimanggis Kota Depok Jawa Barat','','','','','','','','','','',' ','',1,0),(3,'PT Anugrah Pharmindo Lestari','','','','','','','','','','','',' ','',1,0),(4,'PT Enseval Putera Megatrading','Jl. Toyogiri Selatan No. 90 RT.004/Rw.003 Bekasi','','','','','','','','','','',' ','',1,0),(5,'PT Mandiri Medika Farma','',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',1,0);
/*!40000 ALTER TABLE `manufacturer_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `module`
--

DROP TABLE IF EXISTS `module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `directory` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `module`
--

LOCK TABLES `module` WRITE;
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
INSERT INTO `module` VALUES (1,'Invoice','','','invoice',1),(2,'Customer','','','customer',1),(3,'Medicine','','','medicine',1),(4,'Manufacturer','','','manufacturer',1),(5,'Purchase','','','purchase',1),(6,'Stock','','','stock',1),(7,'Return','','','return',1),(8,'Report','','','report',1),(9,'Accounts','','','accounts',1),(10,'Bank','','','bank',1),(11,'Tax','','','tax',1),(12,'Human Resource','','','human_resource_info',1),(13,'Supplier','','','supplier',1),(14,'Service','','','service',1),(15,'Search','','','search',1),(16,'Settings','','','settings',1);
/*!40000 ALTER TABLE `module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_type`
--

DROP TABLE IF EXISTS `payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type_name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=active,0=inactive',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_type`
--

LOCK TABLES `payment_type` WRITE;
/*!40000 ALTER TABLE `payment_type` DISABLE KEYS */;
INSERT INTO `payment_type` VALUES (1,'Cash Payment',1),(2,'Bank Payment',1);
/*!40000 ALTER TABLE `payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payroll_tax_setup`
--

DROP TABLE IF EXISTS `payroll_tax_setup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payroll_tax_setup` (
  `tax_setup_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `start_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `end_amount` decimal(12,2) NOT NULL DEFAULT 0.00,
  `rate` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`tax_setup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payroll_tax_setup`
--

LOCK TABLES `payroll_tax_setup` WRITE;
/*!40000 ALTER TABLE `payroll_tax_setup` DISABLE KEYS */;
/*!40000 ALTER TABLE `payroll_tax_setup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_information`
--

DROP TABLE IF EXISTS `person_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_information` (
  `person_id` varchar(50) NOT NULL,
  `person_name` varchar(50) NOT NULL,
  `person_phone` varchar(50) NOT NULL,
  `person_address` text NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_information`
--

LOCK TABLES `person_information` WRITE;
/*!40000 ALTER TABLE `person_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_ledger`
--

DROP TABLE IF EXISTS `person_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_ledger` (
  `transaction_id` varchar(50) NOT NULL,
  `person_id` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  `debit` decimal(12,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(10,2) NOT NULL DEFAULT 0.00,
  `details` text NOT NULL,
  `status` int(11) NOT NULL COMMENT '1=no paid,2=paid',
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_ledger`
--

LOCK TABLES `person_ledger` WRITE;
/*!40000 ALTER TABLE `person_ledger` DISABLE KEYS */;
/*!40000 ALTER TABLE `person_ledger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_loan`
--

DROP TABLE IF EXISTS `personal_loan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_loan`
--

LOCK TABLES `personal_loan` WRITE;
/*!40000 ALTER TABLE `personal_loan` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_loan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pesonal_loan_information`
--

DROP TABLE IF EXISTS `pesonal_loan_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pesonal_loan_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` varchar(50) NOT NULL,
  `person_name` varchar(50) NOT NULL,
  `person_phone` varchar(30) NOT NULL,
  `person_address` text NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pesonal_loan_information`
--

LOCK TABLES `pesonal_loan_information` WRITE;
/*!40000 ALTER TABLE `pesonal_loan_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `pesonal_loan_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,'Obat Lambung',1),(2,'Obat Panas, Batuk, Pilek Anak',1);
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_information`
--

DROP TABLE IF EXISTS `product_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_information`
--

LOCK TABLES `product_information` WRITE;
/*!40000 ALTER TABLE `product_information` DISABLE KEYS */;
INSERT INTO `product_information` VALUES (1,'1234567890','1','Magasida','Magasida 105','Meredakan Lambung','10','1','15000','0','Obat Hijau',1,10000.00,'Tablet','Meredakan Lambung dan Maag','https://apotik.fajri-hulvi.com/my-assets/image/product/6f23be85ecfb605630888ffdb68897a2.jpeg',1),(2,'110526','2','Ternix Plus ','Paracetamol, Pseudoephedrine HCL, CTM, Guaifenesin','15 mg','60','','15000','0','Obat biru',2,11866.67,'Sirup','','https://apotik.fajri-hulvi.com/my-assets/image/product.png',1),(3,'77324394','','Alofar 100 mg','Allopurinol 100 mg','','1','','4000','0','Obat Keras (Merah)',5,2538.60,'Strip','','https://apotik.fajri-hulvi.com/my-assets/image/product.png',1),(4,'77845295','','Folic Acid 1 mg Triman','Folic Acid 1 mg','','1','','2500','0','Obat Bebas (Hijau)',5,735.00,'Strip','','https://apotik.fajri-hulvi.com/my-assets/image/product.png',1),(5,'48157456','','Gentian Violet 10 ml','1% methyl rosaniline chloride.','','1','','5000','0','Obat Bebas (Hijau)',5,2882.00,'Botol','','https://apotik.fajri-hulvi.com/my-assets/image/product.png',1),(6,'73495937','','Glimepiride 1 mg Dexa','Glimepiride 1 mg','','1','','4000','0','Obat Keras (Merah)',5,2113.50,'Strip','','https://apotik.fajri-hulvi.com/my-assets/image/product.png',1),(7,'31624464','','Praxion Suspensi 60 ml','Paracetamol 120 mg','','1','','30000','0','Obat Bebas (Hijau)',5,22157.00,'Botol','','https://apotik.fajri-hulvi.com/my-assets/image/product.png',1),(8,'24991265','','Praxion Forte Suspensi 60 ml','Paracetamol 250 mg','','1','','37000','0','Obat Bebas (Hijau)',5,26177.00,'Botol','','https://apotik.fajri-hulvi.com/my-assets/image/product.png',1),(9,'63977236','','Grafalin 4 mg','Salbutamol sulfate 4 mg','','1','','3000','0','Obat Keras (Merah)',5,1654.00,'Strip','','https://apotik.fajri-hulvi.com/my-assets/image/product.png',1),(10,'44465681','','Acifar Cream 5 gr','Acyclovir 5%','','1','','10000','0','Obat Keras (Merah)',5,5580.00,'Tube','','https://apotik.fajri-hulvi.com/my-assets/image/product.png',1);
/*!40000 ALTER TABLE `product_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_purchase`
--

DROP TABLE IF EXISTS `product_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_purchase`
--

LOCK TABLES `product_purchase` WRITE;
/*!40000 ALTER TABLE `product_purchase` DISABLE KEYS */;
INSERT INTO `product_purchase` VALUES ('909090','1',1000000.00,NULL,'2024-08-09','',1,1,'20240809233510','',1),('9090909','1',1000000.00,NULL,'2026-07-23','',1,2,'20260723053701','',1);
/*!40000 ALTER TABLE `product_purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_purchase_details`
--

DROP TABLE IF EXISTS `product_purchase_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_purchase_details`
--

LOCK TABLES `product_purchase_details` WRITE;
/*!40000 ALTER TABLE `product_purchase_details` DISABLE KEYS */;
INSERT INTO `product_purchase_details` VALUES ('iakYRJ5I3FiFlXy','20240809233510','1234567890',100.00,10000.00,1000000.00,NULL,'1-1','2025-06-30',1,1),('NPpzpsbY8te79nS','20260723053701','1234567890',100.00,10000.00,1000000.00,NULL,'2-1','2026-10-03',1,2);
/*!40000 ALTER TABLE `product_purchase_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_return`
--

DROP TABLE IF EXISTS `product_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_return`
--

LOCK TABLES `product_return` WRITE;
/*!40000 ALTER TABLE `product_return` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_service`
--

DROP TABLE IF EXISTS `product_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_service` (
  `service_id` int(11) NOT NULL AUTO_INCREMENT,
  `service_name` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `charge` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_service`
--

LOCK TABLES `product_service` WRITE;
/*!40000 ALTER TABLE `product_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_type`
--

DROP TABLE IF EXISTS `product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` varchar(255) DEFAULT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_type`
--

LOCK TABLES `product_type` WRITE;
/*!40000 ALTER TABLE `product_type` DISABLE KEYS */;
INSERT INTO `product_type` VALUES (1,'QQ7EHK74GBT5TKA','Obat Bebas (Hijau)',1),(2,'2EFPL9YX4G4L3Y6','Obat Bebas Terbatas (Biru)',1),(3,'6AANUO5PDL4RXPI','Obat Keras (Merah)',1);
/*!40000 ALTER TABLE `product_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=333 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (217,1,1,1,1,1,1),(218,2,1,1,1,1,1),(219,3,1,1,1,1,1),(220,4,1,1,1,1,1),(221,27,1,1,1,1,1),(222,28,1,1,1,1,1),(223,29,1,0,0,0,0),(224,30,1,0,0,0,0),(225,22,1,1,1,1,1),(226,23,1,1,1,1,1),(227,24,1,1,1,1,1),(228,25,1,1,1,1,1),(229,26,1,1,1,1,1),(230,105,1,1,1,1,1),(231,106,1,1,1,1,1),(236,35,1,1,1,1,1),(237,36,1,1,1,1,1),(238,77,1,1,1,1,1),(239,80,1,1,1,1,1),(240,60,1,1,1,1,1),(241,61,1,1,1,1,1),(242,62,1,1,1,1,1),(243,63,1,1,1,1,1),(244,81,1,1,1,1,1),(245,82,1,1,1,1,1),(246,83,1,1,1,1,1),(247,84,1,1,1,1,1),(248,85,1,1,1,1,1),(249,5,1,0,0,0,0),(250,6,1,0,0,0,0),(251,7,1,0,0,0,0),(252,8,1,0,0,0,0),(253,9,1,0,0,0,0),(254,10,1,0,0,0,0),(255,11,1,0,0,0,0),(256,12,1,0,0,0,0),(257,13,1,0,0,0,0),(258,14,1,0,0,0,0),(259,15,1,0,0,0,0),(260,16,1,0,0,0,0),(261,17,1,0,0,0,0),(262,18,1,0,0,0,0),(263,19,1,0,0,0,0),(264,20,1,0,0,0,0),(265,21,1,0,0,0,0),(266,110,1,0,0,0,0),(267,86,1,0,0,0,0),(268,87,1,0,0,0,0),(269,88,1,0,0,0,0),(270,72,1,0,0,0,0),(271,73,1,0,0,0,0),(272,74,1,0,0,0,0),(273,75,1,0,0,0,0),(274,76,1,0,0,0,0),(275,37,1,0,0,0,0),(276,38,1,0,0,0,0),(277,39,1,0,0,0,0),(278,40,1,0,0,0,0),(279,41,1,0,0,0,0),(280,42,1,0,0,0,0),(281,43,1,0,0,0,0),(282,44,1,0,0,0,0),(283,45,1,0,0,0,0),(284,46,1,0,0,0,0),(285,47,1,0,0,0,0),(286,48,1,0,0,0,0),(287,49,1,0,0,0,0),(288,50,1,0,0,0,0),(289,51,1,0,0,0,0),(290,52,1,0,0,0,0),(291,53,1,0,0,0,0),(292,54,1,0,0,0,0),(293,55,1,0,0,0,0),(294,56,1,0,0,0,0),(295,57,1,0,0,0,0),(296,58,1,0,0,0,0),(297,89,1,0,0,0,0),(298,90,1,0,0,0,0),(299,91,1,0,0,0,0),(300,92,1,0,0,0,0),(301,93,1,0,0,0,0),(302,94,1,0,0,0,0),(306,68,1,0,0,0,0),(307,69,1,0,0,0,0),(308,70,1,0,0,0,0),(309,71,1,0,0,0,0),(310,64,1,1,1,1,1),(311,65,1,1,1,1,1),(312,66,1,1,1,1,1),(313,67,1,1,1,1,1),(314,59,1,0,0,0,0),(315,95,1,0,0,0,0),(316,96,1,0,0,0,0),(317,97,1,0,0,0,0),(318,98,1,0,0,0,0),(319,99,1,0,0,0,0),(320,100,1,0,0,0,0),(321,101,1,0,0,0,0),(322,102,1,0,0,0,0),(323,103,1,0,0,0,0),(324,104,1,0,0,0,0),(325,200,1,1,1,1,1),(326,201,1,1,1,1,1),(327,202,1,1,1,1,1),(328,210,1,1,1,1,1),(329,31,1,1,1,1,1),(330,32,1,1,1,1,1),(331,33,1,1,1,1,1),(332,211,1,0,1,1,0);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary_sheet_generate`
--

DROP TABLE IF EXISTS `salary_sheet_generate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salary_sheet_generate` (
  `ssg_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `gdate` varchar(30) DEFAULT NULL,
  `start_date` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `end_date` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `generate_by` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`ssg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary_sheet_generate`
--

LOCK TABLES `salary_sheet_generate` WRITE;
/*!40000 ALTER TABLE `salary_sheet_generate` DISABLE KEYS */;
/*!40000 ALTER TABLE `salary_sheet_generate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary_type`
--

DROP TABLE IF EXISTS `salary_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salary_type` (
  `salary_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `sal_name` varchar(100) NOT NULL,
  `salary_type` varchar(50) NOT NULL,
  `status` varchar(30) NOT NULL,
  PRIMARY KEY (`salary_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary_type`
--

LOCK TABLES `salary_type` WRITE;
/*!40000 ALTER TABLE `salary_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `salary_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sec_role`
--

DROP TABLE IF EXISTS `sec_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sec_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sec_role`
--

LOCK TABLES `sec_role` WRITE;
/*!40000 ALTER TABLE `sec_role` DISABLE KEYS */;
INSERT INTO `sec_role` VALUES (1,'Owner');
/*!40000 ALTER TABLE `sec_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sec_userrole`
--

DROP TABLE IF EXISTS `sec_userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sec_userrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `roleid` int(11) NOT NULL,
  `createby` varchar(50) NOT NULL,
  `createdate` datetime DEFAULT NULL,
  UNIQUE KEY `ID` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sec_userrole`
--

LOCK TABLES `sec_userrole` WRITE;
/*!40000 ALTER TABLE `sec_userrole` DISABLE KEYS */;
INSERT INTO `sec_userrole` VALUES (1,'RRqlFgAVhKQeiPM',1,'2','2026-07-23 03:46:32');
/*!40000 ALTER TABLE `sec_userrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_invoice`
--

DROP TABLE IF EXISTS `service_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_invoice`
--

LOCK TABLES `service_invoice` WRITE;
/*!40000 ALTER TABLE `service_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_invoice_details`
--

DROP TABLE IF EXISTS `service_invoice_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_invoice_details`
--

LOCK TABLES `service_invoice_details` WRITE;
/*!40000 ALTER TABLE `service_invoice_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_invoice_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_settings`
--

DROP TABLE IF EXISTS `sms_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_settings`
--

LOCK TABLES `sms_settings` WRITE;
/*!40000 ALTER TABLE `sms_settings` DISABLE KEYS */;
INSERT INTO `sms_settings` VALUES (1,'60d6748a','NrW61s2AfTbgYkNk','isahaq',0,0,1,0);
/*!40000 ALTER TABLE `sms_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_fixed_asset`
--

DROP TABLE IF EXISTS `stock_fixed_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_fixed_asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` int(11) NOT NULL,
  `item_code` varchar(50) NOT NULL,
  `qty` float NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_fixed_asset`
--

LOCK TABLES `stock_fixed_asset` WRITE;
/*!40000 ALTER TABLE `stock_fixed_asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_fixed_asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_module`
--

DROP TABLE IF EXISTS `sub_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sub_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(100) NOT NULL,
  `directory` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_module`
--

LOCK TABLES `sub_module` WRITE;
/*!40000 ALTER TABLE `sub_module` DISABLE KEYS */;
INSERT INTO `sub_module` VALUES (1,1,'New Invoice','','','new_invoice',1),(2,1,'Manage Invoice','','','manage_invoice',1),(3,1,'POS INVOICE','','','pos_invoice',1),(4,1,'GUI POS','','','gui_pos',1),(5,9,'Chart Of Account','','','show_tree',1),(6,9,'Manufacturer Payment','','','manufacturer_payment',1),(7,9,'Supplier Payment','','','supplier_payment',1),(8,9,'Customer Receive','','','customer_receive',1),(9,9,'Debit Voucher','','','debit_voucher',1),(10,9,'Credit Voucher','','','credit_voucher',1),(11,9,'Contra Voucher','','','contra_voucher',1),(12,9,'Journal Voucher','','','journal_voucher',1),(13,9,'Voucher Approval','','','aprove_v',1),(14,9,'Report','','','ac_report',1),(15,9,'Cash Book','','','cash_book',1),(16,9,'Bank Book','','','bank_book',1),(17,9,'General Ledger','','','general_ledger',1),(18,9,'Inventory Ledger','','','Inventory_ledger',1),(19,9,'Cash Flow','','','cash_flow_report',1),(20,9,'Profit Loss Statement','','','profit_loss_report',1),(21,9,'Trial Balance','','','trial_balance',1),(22,3,'Category','','','add_category',1),(23,3,'Medicine Type','','','medicine_type',1),(24,3,'Add Medicine','','','add_medicine',1),(25,3,'Import Medicine(CSV)','','','import_medicine_csv',1),(26,3,'Manage Medicine','','','manage_medicine',1),(27,2,'Add Customer','','','add_customer',1),(28,2,'Manage Customer','','','manage_customer',1),(29,2,'Credit Customer','','','credit_customer',1),(30,2,'Paid Customer','','','paid_customer',1),(31,4,'Add Manufacturer','','','add_manufacturer',1),(32,4,'Manage Manufacturer','','','manage_manufacturer',1),(33,4,'Manufacturer Ledger','','','manufacturer_ledger',1),(34,4,'Manufacturer Sales Details','','','manufacturer_sales_details',1),(35,5,'Add Purchase','','','add_purchase',1),(36,5,'Manage Purchase','','','manage_purchase',1),(37,12,'Add Designation','','','add_designation',1),(38,12,'Manage Designation','','','manage_designation',1),(39,12,'Add Employee','','','add_employee',1),(40,12,'Manage Employee','','','manage_employee',1),(41,12,'Add Attendance','','','add_attendance',1),(42,12,'Manage Attendance','','','manage_attendance',1),(43,12,'Attendance Report','','','attendance_report',1),(44,12,'Add Benefits','','','add_benefits',1),(45,12,'Manage Benefits','','','manage_benefits',1),(46,12,'Add Salary Setup','','','add_salary_setup',1),(47,12,'Manage Salary Setup','','','manage_salary_setup',1),(48,12,'Salary Generate','','','salary_generate',1),(49,12,'Manage Salary Generate','','','manage_salary_generate',1),(50,12,'Salary Payment','','','salary_payment',1),(51,12,'Add Expense Item','','','add_expense_item',1),(52,12,'Manage Expense Item','','','manage_expense_item',1),(53,12,'Add Expense','','','add_expense',1),(54,12,'Manage Expense','','','manage_expense',1),(55,12,'Add Fixed Assets','','','add_fixed_assets',1),(56,12,'Fixed Asset List','','','fixed_assets_list',1),(57,12,'Purchase Fixed Assets','','','fixed_assets_purchase',1),(58,12,'Fixed Asset Purchase List','','','fixed_assets_purchase_manage',1),(59,16,'Manage Company','','','manage_company',1),(60,7,'Return','','','return',1),(61,7,'Stock Return List','','','stock_return_list',1),(62,7,'Manufacturer Return List','','','manufacturer_return_list',1),(63,7,'Wastage Return List','','','wastage_return_list',1),(64,15,'Medicine','','','medicine_search',1),(65,15,'Customer','','','customer_search',1),(66,15,'Invoice','','','invoice_search',1),(67,15,'Purchase','','','purcahse_search',1),(68,14,'Add Service','','','create_service',1),(69,14,'Manage Service','','','manage_service',1),(70,14,'Service Invoice','','','service_invoice',1),(71,14,'Manage Service Invoice','','','manage_service_invoice',1),(72,11,'Tax Settings','','','tax_settings',1),(73,11,'Add Income Tax','','','add_incometax',1),(74,11,'Manage Income Tax','','','manage_income_tax',1),(75,11,'Tax Report','','','tax_report',1),(76,11,'Invoice Wise Tax Report','','','invoice_wise_tax_report',1),(77,6,'Stock Report','','','stock_report',1),(80,6,'Stock Report(Batch Wise)','','','stock_report_batch_wise',1),(81,8,'Today\'s Report','','','todays_report',1),(82,8,'Sales Report','','','sales_report',1),(83,8,'Purchase Report','','','purchase_report',1),(84,8,'Sales Report(Medicine Wise)','','','sales_report_medicine_wise',1),(85,8,'Profit/Loss','','','profit_loss',1),(86,10,'Add New Bank','','','add_new_bank',1),(87,10,'Bank Transaction','','','bank_transaction',1),(88,10,'Manage Bank','','','manage_bank',1),(89,12,'Add Person(Personal Loan)','','','office_add_person',1),(90,12,'Manage Person(Personal Loan)','','','office_manage_loan',1),(91,12,'Add Person(Office Loan)','','','personal_add_person',1),(92,12,'Add Loan(Office Loan)','','','personal_add_loan',1),(93,12,'Add Payment(Office Loan)','','','personal_add_payment',1),(94,12,'Manage Loan(Office Loan)','','','personal_manage_loan',1),(95,16,'Add User','','','add_user',1),(96,16,'Manage Users','','','manage_users',1),(97,16,'Lanaguage','','','language',1),(98,16,'Currency','','','currency',1),(99,16,'Web Setting','','','soft_setting',1),(100,16,'Add Role','','','add_role',1),(101,16,'Role List','','','role_list',1),(102,16,'Assign User Role','','','user_assign_role',1),(103,16,'Permission','','','permission',1),(104,16,'SMS','','','configure_sms',1),(105,3,'Add Unit','','','add_unit',1),(106,3,'Unit List','','','unit_list',1),(107,13,'Add Supplier','','','add_supplier',1),(108,13,'Manage Supplier','','','manage_supplier',1),(109,13,'Supplier Ledger','','','supplier_ledger',1),(110,9,'COA Print','','','coa_print',1),(200,16,'Add Payment Type','','','add_payment_type',1),(201,16,'Payment Type List','','','payment_type_list',1),(202,16,'Edit Payment Type','','','edit_payment_type',1),(210,16,'Receipt Header Footer','','','receipt_header_footer',1),(211,16,'Expiry Alert Setting','','','expiry_alert_setting',1);
/*!40000 ALTER TABLE `sub_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_information`
--

DROP TABLE IF EXISTS `supplier_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` varchar(100) NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `mobile` varchar(100) NOT NULL,
  `details` varchar(255) NOT NULL,
  `status` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_information`
--

LOCK TABLES `supplier_information` WRITE;
/*!40000 ALTER TABLE `supplier_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_ledger`
--

DROP TABLE IF EXISTS `supplier_ledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_ledger`
--

LOCK TABLES `supplier_ledger` WRITE;
/*!40000 ALTER TABLE `supplier_ledger` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier_ledger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `synchronizer_setting`
--

DROP TABLE IF EXISTS `synchronizer_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `synchronizer_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `port` varchar(10) NOT NULL,
  `debug` varchar(10) NOT NULL,
  `project_root` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `synchronizer_setting`
--

LOCK TABLES `synchronizer_setting` WRITE;
/*!40000 ALTER TABLE `synchronizer_setting` DISABLE KEYS */;
/*!40000 ALTER TABLE `synchronizer_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_collection`
--

DROP TABLE IF EXISTS `tax_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `customer_id` varchar(30) NOT NULL,
  `relation_id` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_collection`
--

LOCK TABLES `tax_collection` WRITE;
/*!40000 ALTER TABLE `tax_collection` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_information`
--

DROP TABLE IF EXISTS `tax_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_information` (
  `tax_id` varchar(15) NOT NULL,
  `tax` float DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`tax_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_information`
--

LOCK TABLES `tax_information` WRITE;
/*!40000 ALTER TABLE `tax_information` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_information` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_settings`
--

DROP TABLE IF EXISTS `tax_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tax_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `default_value` float NOT NULL,
  `tax_name` varchar(250) NOT NULL,
  `nt` int(11) NOT NULL,
  `reg_no` varchar(100) DEFAULT NULL,
  `is_show` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_settings`
--

LOCK TABLES `tax_settings` WRITE;
/*!40000 ALTER TABLE `tax_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unit_name` varchar(200) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
INSERT INTO `unit` VALUES (1,'Tablet',1),(2,'Sirup',1),(3,'Strip',1),(4,'Sachet',1),(5,'pcs',1),(6,'Botol',1),(7,'Tube',1);
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login`
--

DROP TABLE IF EXISTS `user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(15) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_type` int(2) DEFAULT NULL,
  `security_code` varchar(255) DEFAULT NULL,
  `status` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login`
--

LOCK TABLES `user_login` WRITE;
/*!40000 ALTER TABLE `user_login` DISABLE KEYS */;
INSERT INTO `user_login` VALUES (1,'2','admin@admin.com','035e7767f3f2940b3a6b2817cbdbe9e6',1,NULL,1),(2,'RRqlFgAVhKQeiPM','alang@gmail.com','035e7767f3f2940b3a6b2817cbdbe9e6',2,NULL,1);
/*!40000 ALTER TABLE `user_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2','User','Admin',NULL,NULL,NULL,NULL,NULL,'https://apotik.fajri-hulvi.com/assets/dist/img/profile_picture/86736c1bc38a0efc836bcc42bc927360.png',1),(2,'RRqlFgAVhKQeiPM','Alang 1','Apotik',NULL,NULL,NULL,NULL,NULL,'http://localhost/apotik_alang/assets/dist/img/profile_picture/profile.jpg',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `web_setting`
--

DROP TABLE IF EXISTS `web_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_setting` (
  `setting_id` int(11) NOT NULL AUTO_INCREMENT,
  `logo` varchar(255) DEFAULT NULL,
  `invoice_logo` varchar(255) DEFAULT NULL,
  `favicon` varchar(255) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `timezone` varchar(200) DEFAULT NULL,
  `currency_position` varchar(10) DEFAULT NULL,
  `footer_text` varchar(255) DEFAULT NULL,
  `receipt_header` text DEFAULT NULL,
  `receipt_footer` text DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `rtr` varchar(255) DEFAULT NULL,
  `captcha` int(11) DEFAULT 1 COMMENT '0=active,1=inactive',
  `site_key` varchar(250) DEFAULT NULL,
  `secret_key` varchar(250) DEFAULT NULL,
  `discount_type` int(11) DEFAULT 1,
  `expiry_alert_months` int(11) NOT NULL DEFAULT 8 COMMENT 'Ambang notifikasi obat mendekati kedaluwarsa (bulan)',
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `web_setting`
--

LOCK TABLES `web_setting` WRITE;
/*!40000 ALTER TABLE `web_setting` DISABLE KEYS */;
INSERT INTO `web_setting` VALUES (1,'http://localhost/apotik_alang/./my-assets/image/logo/e6ad58610246cd09fa2841f3d1186812.png','https://apotik.fajri-hulvi.com/./my-assets/image/logo/c6258a12c738ad6a2aa458ad162b84cd.png','https://apotik.fajri-hulvi.com/my-assets/image/logo/0cf8f0295246576edfd81bb8f870368e.png','Rp','Asia/Jakarta','0','Copyright© 2026. All rights reserved.','<p>APOTEK ALANG FARMA</p><p>Jl.&nbsp; KH. Tajudin RT. 06 / RW. 03 Kel. Bahagia, Kec. Babelan Bekasi</p><p>SIA : 02052400529060001</p><p>apt. Tirah Mawaddah S.Farm</p><p>SIPA : KS.08/2330/DPMPTSP/Apt/2024</p><p>Telp :&nbsp; 081278480303<br></p>','<p>TERIMA KASIH&nbsp;</p><p>Semoga Lekas Sembuh</p><p>Barang Yang Dibeli</p><p>Tidak Dapat Ditukar Kembali<br></p>','bahasa','0',1,'','',1,8);
/*!40000 ALTER TABLE `web_setting` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-28  9:15:27
