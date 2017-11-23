-- MySQL dump 10.13  Distrib 5.7.20, for Win32 (AMD64)
--
-- Host: localhost    Database: brynhildr
-- ------------------------------------------------------
-- Server version	5.7.20-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `UID` int(11) NOT NULL,
  `FIRST_NAME` varchar(100) DEFAULT NULL,
  `LAST_NAME` varchar(100) DEFAULT NULL,
  `PHONE_NUM` char(11) DEFAULT NULL,
  `CELLPH_NUM` char(11) DEFAULT NULL,
  `STATE` varchar(20) DEFAULT NULL,
  `CITY` varchar(30) DEFAULT NULL,
  `STREET` varchar(50) DEFAULT NULL,
  `ZIP_CODE` char(5) DEFAULT NULL,
  `LEVEL` int(11) DEFAULT NULL,
  `cash_balan` decimal(65,4) DEFAULT NULL,
  `oil_balan` decimal(65,4) DEFAULT NULL,
  PRIMARY KEY (`UID`),
  UNIQUE KEY `PHONE_NUM` (`PHONE_NUM`),
  UNIQUE KEY `CELLPH_NUM` (`CELLPH_NUM`),
  CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `users` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (2,'Altria','Pendragon',NULL,NULL,NULL,'London',NULL,NULL,1,955977.0000,103425.8155);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients_trans`
--

DROP TABLE IF EXISTS `clients_trans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients_trans` (
  `T_ID` int(11) NOT NULL AUTO_INCREMENT,
  `t_date` datetime DEFAULT NULL,
  `C_ID` int(11) NOT NULL,
  `TR_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`T_ID`),
  KEY `C_ID` (`C_ID`),
  KEY `TR_ID` (`TR_ID`),
  CONSTRAINT `clients_trans_ibfk_1` FOREIGN KEY (`C_ID`) REFERENCES `clients` (`UID`),
  CONSTRAINT `clients_trans_ibfk_2` FOREIGN KEY (`TR_ID`) REFERENCES `traders` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients_trans`
--

LOCK TABLES `clients_trans` WRITE;
/*!40000 ALTER TABLE `clients_trans` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comm_rates`
--

DROP TABLE IF EXISTS `comm_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comm_rates` (
  `rate_silver` decimal(65,4) DEFAULT NULL,
  `rate_gold` decimal(65,4) DEFAULT NULL,
  `rate_date` date NOT NULL,
  PRIMARY KEY (`rate_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comm_rates`
--

LOCK TABLES `comm_rates` WRITE;
/*!40000 ALTER TABLE `comm_rates` DISABLE KEYS */;
INSERT INTO `comm_rates` VALUES (0.0002,0.0015,'2017-11-22');
/*!40000 ALTER TABLE `comm_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oil_transactions`
--

DROP TABLE IF EXISTS `oil_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oil_transactions` (
  `T_ID` int(11) NOT NULL,
  `comm_oil` decimal(65,4) DEFAULT NULL,
  `comm_cash` decimal(65,4) DEFAULT NULL,
  `oil_balan` decimal(65,4) DEFAULT NULL,
  `cash_balan` decimal(65,4) DEFAULT NULL,
  `comm_rate` decimal(65,4) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`T_ID`),
  CONSTRAINT `oil_transactions_ibfk_1` FOREIGN KEY (`T_ID`) REFERENCES `clients_trans` (`T_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oil_transactions`
--

LOCK TABLES `oil_transactions` WRITE;
/*!40000 ALTER TABLE `oil_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oil_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oilprices`
--

DROP TABLE IF EXISTS `oilprices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oilprices` (
  `price_date` date NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`price_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oilprices`
--

LOCK TABLES `oilprices` WRITE;
/*!40000 ALTER TABLE `oilprices` DISABLE KEYS */;
INSERT INTO `oilprices` VALUES ('2017-11-21',39),('2017-11-22',33);
/*!40000 ALTER TABLE `oilprices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payments` (
  `T_ID` int(11) NOT NULL,
  `AMOUNT_PAY` int(11) NOT NULL,
  `CASH_BALAN` varchar(255) DEFAULT NULL,
  `OIL_BALAN` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`T_ID`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`T_ID`) REFERENCES `clients_trans` (`T_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `traders`
--

DROP TABLE IF EXISTS `traders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `traders` (
  `UID` int(11) NOT NULL,
  `TRADER_NAME` int(11) DEFAULT NULL,
  PRIMARY KEY (`UID`),
  CONSTRAINT `traders_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `users` (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `traders`
--

LOCK TABLES `traders` WRITE;
/*!40000 ALTER TABLE `traders` DISABLE KEYS */;
/*!40000 ALTER TABLE `traders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `EMAIL` varchar(100) DEFAULT NULL,
  `PASSWORD` char(32) DEFAULT NULL,
  `TYPE` int(11) NOT NULL,
  PRIMARY KEY (`UID`),
  UNIQUE KEY `EMAIL` (`EMAIL`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'1@2.3','96e79218965eb72c92a549dd5a330112',0),(2,'altria@gmail.com','e3ceb5881a0a1fdaad01296d7554868d',0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-22 23:01:04
