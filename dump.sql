-- MySQL dump 10.13  Distrib 5.7.19, for osx10.12 (x86_64)
--
-- Host: localhost    Database: brynhildr
-- ------------------------------------------------------
-- Server version	5.7.19

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
-- Dumping data for table `CLIENTS`
--

LOCK TABLES `CLIENTS` WRITE;
/*!40000 ALTER TABLE `CLIENTS` DISABLE KEYS */;
INSERT INTO `CLIENTS` VALUES (2,'Altria','Pendragon',NULL,NULL,NULL,'London',NULL,NULL,1,32408619.8000,2147503.7655);
/*!40000 ALTER TABLE `CLIENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `COMM_RATES`
--

LOCK TABLES `COMM_RATES` WRITE;
/*!40000 ALTER TABLE `COMM_RATES` DISABLE KEYS */;
INSERT INTO `COMM_RATES` VALUES (0.0002,0.0015,'2017-11-22');
/*!40000 ALTER TABLE `COMM_RATES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES (1,'1@2.3','96e79218965eb72c92a549dd5a330112',1),(2,'altria@gmail.com','e3ceb5881a0a1fdaad01296d7554868d',0),(3,'m@m.m','96e79218965eb72c92a549dd5a330112',2);
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `cancel_logs`
--

LOCK TABLES `cancel_logs` WRITE;
/*!40000 ALTER TABLE `cancel_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `cancel_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `clients_trans`
--

LOCK TABLES `clients_trans` WRITE;
/*!40000 ALTER TABLE `clients_trans` DISABLE KEYS */;
INSERT INTO `clients_trans` VALUES (3,'2017-11-23 16:11:31',2,NULL,2),(4,'2017-11-23 16:20:27',2,NULL,2),(5,'2017-11-23 16:21:40',2,NULL,2),(6,'2017-11-23 16:23:18',2,NULL,2),(7,'2017-11-23 16:43:23',2,NULL,2),(8,'2017-11-23 16:43:52',2,NULL,2),(9,'2017-11-23 16:45:50',2,NULL,2),(10,'2017-11-23 16:46:49',2,NULL,2),(11,'2017-11-23 16:47:31',2,NULL,2),(12,'2017-11-23 16:47:47',2,NULL,2),(13,'2017-11-23 16:49:36',2,NULL,2),(15,'2017-11-23 16:52:40',2,NULL,2),(16,'2017-11-23 16:52:55',2,NULL,2),(17,'2017-11-23 16:55:27',2,NULL,2),(18,'2017-11-23 16:55:53',2,NULL,2),(19,'2017-11-23 16:56:47',2,NULL,2),(21,'2017-11-23 16:59:15',2,NULL,2),(22,'2017-11-23 23:22:53',2,1,1),(23,'2017-11-23 23:23:31',2,1,2),(25,'2017-11-23 23:26:38',2,1,1),(26,'2017-11-24 18:45:56',2,NULL,1),(27,'2017-11-24 18:46:17',2,NULL,0),(28,'2017-11-24 18:46:33',2,NULL,2),(29,'2017-11-24 18:47:17',2,1,2),(30,'2017-11-24 18:47:26',2,1,1),(31,'2017-12-01 13:52:14',2,NULL,1);
/*!40000 ALTER TABLE `clients_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `oil_transactions`
--

LOCK TABLES `oil_transactions` WRITE;
/*!40000 ALTER TABLE `oil_transactions` DISABLE KEYS */;
INSERT INTO `oil_transactions` VALUES (22,0.0000,247.5000,2069020.4155,35002593.5000,0.0015,33.0000,5000),(25,0.0000,29.7000,2068520.2655,35019064.8000,0.0015,33.0000,600),(26,0.0000,495.0000,2058520.2655,35348569.8000,0.0015,33.0000,10000),(27,0.0000,4950.0000,2158520.2655,32043619.8000,0.0015,33.0000,100000),(30,15.0000,0.0000,2148505.2655,32375619.8000,0.0015,33.0000,10000),(31,1.5000,0.0000,2147503.7655,32408619.8000,0.0015,33.0000,1000);
/*!40000 ALTER TABLE `oil_transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER cancel_oil_trigger
    AFTER DELETE
    ON OIL_TRANSACTIONS FOR EACH ROW
    BEGIN
DELETE FROM CLIENTS_TRANS WHERE T_ID = OLD.T_ID;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `oilprices`
--

LOCK TABLES `oilprices` WRITE;
/*!40000 ALTER TABLE `oilprices` DISABLE KEYS */;
INSERT INTO `oilprices` VALUES ('2017-11-21',39.0000),('2017-11-22',33.0000);
/*!40000 ALTER TABLE `oilprices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (3,100000000,'34837177.0000'),(4,50,'34837227.0000'),(5,70,'34837297.0000'),(6,9,'34837306.0000'),(7,2,'34837308.0000'),(8,3,'34837311.0000'),(9,6,'34837317.0000'),(10,100,'34837417.0000'),(11,50,'34837467.0000'),(12,70,'34837537.0000'),(13,9,'34837546.0000'),(15,3,'34837550.0000'),(16,5,'34837555.0000'),(17,76,'34837631.0000'),(18,67,'34837698.0000'),(19,54,'34837752.0000'),(21,56,'34837841.0000'),(23,1,'35002594.5000'),(28,1000,'32044619.8000'),(29,1000,'32045619.8000');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER cancel_payment_trigger
    AFTER DELETE
    ON PAYMENTS FOR EACH ROW
    BEGIN
DELETE FROM CLIENTS_TRANS WHERE T_ID = OLD.T_ID;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `traders`
--

LOCK TABLES `traders` WRITE;
/*!40000 ALTER TABLE `traders` DISABLE KEYS */;
INSERT INTO `traders` VALUES (1,'Sigrdrifa');
/*!40000 ALTER TABLE `traders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-02 18:19:14
