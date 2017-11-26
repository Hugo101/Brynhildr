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
-- Dumping data for table `cancel_logs`
--

LOCK TABLES `cancel_logs` WRITE;
/*!40000 ALTER TABLE `cancel_logs` DISABLE KEYS */;
INSERT INTO `cancel_logs` VALUES (1,'2017-11-25 17:51:32','2017-11-25 17:43:34',1,2,NULL,2,NULL,NULL,NULL,956977.0000,NULL,NULL,1000),(2,'2017-11-25 18:07:55','2017-11-25 18:05:31',5,2,NULL,2,NULL,NULL,NULL,958600.0000,NULL,NULL,1000),(3,'2017-11-25 18:08:42','2017-11-25 18:04:01',4,2,NULL,2,NULL,NULL,NULL,957600.0000,NULL,NULL,123),(4,'2017-11-25 18:10:02','2017-11-25 18:04:01',7,2,NULL,2,1.5000,0.0000,102424.3155,990527.0000,0.0015,33,1000),(5,'2017-11-25 18:48:57','2017-11-25 17:56:47',2,2,NULL,2,NULL,NULL,NULL,956977.0000,NULL,NULL,1000),(6,'2017-11-25 18:49:47','2017-11-25 18:02:47',3,2,NULL,2,NULL,NULL,NULL,957477.0000,NULL,NULL,500),(7,'2017-11-25 19:02:20','2017-11-25 18:51:16',8,2,1,0,1.5000,0.0000,104424.3155,923027.0000,0.0015,33,1000),(8,'2017-11-25 19:07:59','2017-11-25 19:02:34',9,2,1,1,0.0000,24.7500,102925.8155,972502.2500,0.0015,33,500),(9,'2017-11-25 19:08:27','2017-11-25 18:07:22',6,2,NULL,2,NULL,NULL,NULL,958650.0000,NULL,NULL,50),(10,'2017-11-25 19:29:45','2017-11-25 19:16:07',12,2,1,2,NULL,NULL,NULL,907052.2500,NULL,NULL,600),(11,'2017-11-25 19:35:32','2017-11-25 19:16:16',13,2,1,1,0.7500,0.0000,104423.5655,923552.2500,0.0015,33,500),(12,'2017-11-25 19:35:35','2017-11-25 19:08:16',10,2,1,0,1.5000,0.0000,104424.3155,923027.0000,0.0015,33,1000),(13,'2017-11-25 19:35:41','2017-11-25 19:15:52',11,2,1,0,0.0000,24.7500,104924.3155,906452.2500,0.0015,33,500);
/*!40000 ALTER TABLE `cancel_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (2,'Altria','Pendragon',NULL,NULL,NULL,'London',NULL,NULL,1,955977.0000,103425.8155);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `clients_trans`
--

LOCK TABLES `clients_trans` WRITE;
/*!40000 ALTER TABLE `clients_trans` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients_trans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `comm_rates`
--

LOCK TABLES `comm_rates` WRITE;
/*!40000 ALTER TABLE `comm_rates` DISABLE KEYS */;
INSERT INTO `comm_rates` VALUES (0.0002,0.0015,'2017-11-22');
/*!40000 ALTER TABLE `comm_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `oil_transactions`
--

LOCK TABLES `oil_transactions` WRITE;
/*!40000 ALTER TABLE `oil_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oil_transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER cancel_oil_trigger
    AFTER DELETE
    ON OIL_TRANSACTIONS FOR EACH ROW
    BEGIN
    SELECT T_DATE, C_ID, TR_ID, T_TYPE FROM CLIENTS_TRANS WHERE T_ID = OLD.T_ID INTO @T_DATE, @C_ID, @TR_ID, @T_TYPE;
    INSERT INTO CANCEL_LOGS (C_DATE, T_DATE, T_ID, C_ID, TR_ID, T_TYPE, COMM_OIL, COMM_CASH, OIL_BALAN, CASH_BALAN, COMM_RATE, PRICE, AMOUNT) VALUES (NOW(), @T_DATE, OLD.T_ID, @C_ID, @TR_ID, @T_TYPE, OLD.COMM_OIL, OLD.COMM_CASH, OLD.OIL_BALAN, OLD.CASH_BALAN, OLD.COMM_RATE, OLD.PRICE, OLD.AMOUNT);
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
INSERT INTO `oilprices` VALUES ('2017-11-21',39),('2017-11-22',33);
/*!40000 ALTER TABLE `oilprices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER cancel_payment_trigger
    AFTER DELETE
    ON PAYMENTS FOR EACH ROW
    BEGIN
    SELECT T_DATE, C_ID, TR_ID, T_TYPE FROM CLIENTS_TRANS WHERE T_ID = OLD.T_ID INTO @T_DATE, @C_ID, @TR_ID, @T_TYPE;
    INSERT INTO CANCEL_LOGS (C_DATE, T_DATE, T_ID, C_ID, TR_ID, T_TYPE, CASH_BALAN, AMOUNT) VALUES (NOW(), @T_DATE, OLD.T_ID, @C_ID, @TR_ID, @T_TYPE, OLD.CASH_BALAN, OLD.AMOUNT);
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
INSERT INTO `traders` VALUES (1,NULL);
/*!40000 ALTER TABLE `traders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'1@2.3','96e79218965eb72c92a549dd5a330112',1),(2,'altria@gmail.com','e3ceb5881a0a1fdaad01296d7554868d',0),(3,'m@m.m','96e79218965eb72c92a549dd5a330112',2);
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

-- Dump completed on 2017-11-25 19:40:57
