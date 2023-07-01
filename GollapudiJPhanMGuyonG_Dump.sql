CREATE DATABASE  IF NOT EXISTS `crypto_portfolio` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `crypto_portfolio`;
-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (x86_64)
--
-- Host: localhost    Database: crypto_portfolio
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Alerts`
--

DROP TABLE IF EXISTS `Alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Alerts` (
  `alert_id` int NOT NULL AUTO_INCREMENT,
  `alert_type` varchar(50) NOT NULL,
  `threshold_value` decimal(18,2) NOT NULL,
  `user_id` int DEFAULT NULL,
  `crypto_id` int DEFAULT NULL,
  PRIMARY KEY (`alert_id`),
  KEY `user_id` (`user_id`),
  KEY `crypto_id` (`crypto_id`),
  CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `alerts_ibfk_2` FOREIGN KEY (`crypto_id`) REFERENCES `Cryptocurrency` (`crypto_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Alerts`
--

LOCK TABLES `Alerts` WRITE;
/*!40000 ALTER TABLE `Alerts` DISABLE KEYS */;
INSERT INTO `Alerts` VALUES (1,'Increase',30000.00,1,1),(2,'Decrease',3000.00,1,2),(3,'Increase',100.00,2,13),(4,'Decrease',0.10,2,5);
/*!40000 ALTER TABLE `Alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cryptocurrency`
--

DROP TABLE IF EXISTS `Cryptocurrency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cryptocurrency` (
  `crypto_id` int NOT NULL AUTO_INCREMENT,
  `crypto_name` varchar(50) NOT NULL,
  PRIMARY KEY (`crypto_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cryptocurrency`
--

LOCK TABLES `Cryptocurrency` WRITE;
/*!40000 ALTER TABLE `Cryptocurrency` DISABLE KEYS */;
INSERT INTO `Cryptocurrency` VALUES (1,'Bitcoin'),(2,'Ethereum'),(3,'Binance Coin'),(4,'Tether'),(5,'Cardano'),(6,'USD Coin'),(7,'XRP'),(8,'Dogecoin'),(9,'Polkadot'),(10,'Uniswap'),(11,'BNB'),(12,'TRON'),(13,'Solana'),(14,'Litecoin'),(15,'Polygon'),(16,'Polkadot'),(17,'Toncoin'),(18,'Dai'),(19,'Shiba Inu'),(20,'Wrapped Bitcoin'),(21,'Avalanche'),(22,'UNUS SED LEO'),(23,'TruUSD'),(24,'Cosmos'),(25,'Chainlink'),(26,'Monero'),(27,'OKB'),(28,'Ethereum Classic'),(29,'Stellas'),(30,'Bitcoin Cash'),(31,'Internet Computer'),(32,'Filecoin'),(33,'Lido DAO'),(34,'Hedera'),(35,'Aptos'),(36,'Cronos'),(37,'Arbitrum'),(38,'Quant'),(39,'NEAR Protocol'),(40,'VeChain'),(41,'Pax Dollar'),(42,'The Graph'),(43,'Algorand'),(44,'Rocket Pool'),(45,'MultiversX'),(46,'Stacks'),(47,'BitDAO'),(48,'ApeCoin'),(49,'Aave'),(50,'Render Token'),(51,'Fantom'),(52,'USDD'),(53,'The Sandbox'),(54,'Optimism'),(55,'EOS'),(56,'KuCoin Token'),(57,'Tezos'),(58,'Maker'),(59,'Theta Network'),(60,'Decentraland'),(61,'Axie Infinity'),(62,'Immutable'),(63,'Gemini Dollar'),(64,'Neo'),(65,'Curve DAO Token'),(66,'Conflux'),(67,'Terra Classic'),(68,'Gala'),(69,'PAX Gold'),(70,'Klatyn'),(71,'Injective'),(72,'Synthetix'),(73,'Flow'),(74,'Chiliz'),(75,'Bitcoin SV'),(76,'Kava'),(77,'Casper'),(78,'BitTorrent'),(79,'XDC Network'),(80,'IOTA'),(81,'GMX'),(82,'Sui'),(83,'Huobi Token'),(84,'Zcash'),(85,'Frax Share'),(86,'GateToken'),(87,'Mina'),(88,'eCash'),(89,'Trust Wallet Token'),(90,'Pepe'),(91,'Dash'),(92,'Nexo'),(93,'WOO Network'),(94,'PancakeSwap'),(95,'Mask Network'),(96,'Loopring'),(97,'Gnosis'),(98,'THORChain'),(99,'Ziliqa'),(100,'Flare'),(101,'Convex Finance');
/*!40000 ALTER TABLE `Cryptocurrency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CryptoExchange`
--

DROP TABLE IF EXISTS `CryptoExchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CryptoExchange` (
  `listing_id` int NOT NULL AUTO_INCREMENT,
  `crypto_id` int DEFAULT NULL,
  `exchange_id` int DEFAULT NULL,
  PRIMARY KEY (`listing_id`),
  KEY `crypto_id` (`crypto_id`),
  KEY `exchange_id` (`exchange_id`),
  CONSTRAINT `cryptoexchange_ibfk_1` FOREIGN KEY (`crypto_id`) REFERENCES `Cryptocurrency` (`crypto_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cryptoexchange_ibfk_2` FOREIGN KEY (`exchange_id`) REFERENCES `Exchange` (`exchange_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CryptoExchange`
--

LOCK TABLES `CryptoExchange` WRITE;
/*!40000 ALTER TABLE `CryptoExchange` DISABLE KEYS */;
INSERT INTO `CryptoExchange` VALUES (1,1,1),(2,2,3),(3,13,48),(4,1,3),(5,2,48),(6,13,1),(7,4,2),(8,5,14),(9,8,10),(10,4,10),(11,5,2),(12,8,14),(13,3,3),(14,7,1),(15,9,10),(16,3,1),(17,7,3),(18,9,10),(19,11,15),(20,19,9),(21,15,13),(22,11,13),(23,19,9),(24,15,15);
/*!40000 ALTER TABLE `CryptoExchange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Exchange`
--

DROP TABLE IF EXISTS `Exchange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Exchange` (
  `exchange_id` int NOT NULL AUTO_INCREMENT,
  `exchange_name` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  PRIMARY KEY (`exchange_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Exchange`
--

LOCK TABLES `Exchange` WRITE;
/*!40000 ALTER TABLE `Exchange` DISABLE KEYS */;
INSERT INTO `Exchange` VALUES (1,'Binance','Malta'),(2,'Coinbase','United States'),(3,'Kraken','United States'),(4,'Bitfinex','Hong Kong'),(5,'Bittrex','United States'),(6,'Huobi','Seychelles'),(7,'OKEx','Malta'),(8,'Bitstamp','Luxembourg'),(9,'KuCoin','Seychelles'),(10,'Gemini','United States'),(11,'Bithumb','South Korea'),(12,'Upbit','South Korea'),(13,'Bybit','Singapore'),(14,'Crypto.com','Singapore'),(15,'Luno','Singapore'),(16,'Bitpanda','Austria'),(17,'BitMEX','Seychelles'),(18,'BitMart','Cayman Islands'),(19,'Gate.io','Cayman Islands'),(20,'Huobi Global','China'),(21,'Crypto.com','United States'),(22,'Bitfinex','United States'),(23,'Kraken','United States'),(24,'Gemini','United States'),(25,'Poloniex','United States'),(26,'Bitstamp','United Kingdom'),(27,'Bittrex','United Kingdom'),(28,'CEX.IO','United Kingdom'),(29,'HitBTC','Estonia'),(30,'YoBit','Russia'),(31,'EXMO','Ukraine'),(32,'C2CX','Malaysia'),(33,'CoinDCX','India'),(34,'WazirX','India'),(35,'CoinDCX Kuber','India'),(36,'CoinSwitch Kuber','India'),(37,'Bitbns','India'),(38,'BuyUcoin','India'),(39,'ZebPay','India'),(40,'CoinZilla','India'),(41,'Coins.ph','Philippines'),(42,'Coinmama','Israel'),(43,'LocalBitcoins','Finland'),(44,'Paxful','United States'),(45,'Changelly','United States'),(46,'Bitpanda Pro','Austria'),(47,'Binance.US','United States'),(48,'FTX.US','United States');
/*!40000 ALTER TABLE `Exchange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Portfolio`
--

DROP TABLE IF EXISTS `Portfolio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Portfolio` (
  `portfolio_id` int NOT NULL AUTO_INCREMENT,
  `portfolio_name` varchar(50) NOT NULL,
  `total_value` decimal(18,2) NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`portfolio_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Portfolio`
--

LOCK TABLES `Portfolio` WRITE;
/*!40000 ALTER TABLE `Portfolio` DISABLE KEYS */;
INSERT INTO `Portfolio` VALUES (1,'John1',85300.00,1),(2,'John2',6000.00,1),(3,'Jane1',3450.00,2),(4,'Jane2',21750.00,2);
/*!40000 ALTER TABLE `Portfolio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `portfolio_id` int DEFAULT NULL,
  `crypto_id` int DEFAULT NULL,
  `exchange_id` int DEFAULT NULL,
  `transaction_date` date DEFAULT NULL,
  `quantity` decimal(18,8) DEFAULT NULL,
  `transaction_type` enum('BUY','SELL') DEFAULT NULL,
  `price` decimal(18,2) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `user_id` (`user_id`),
  KEY `portfolio_id` (`portfolio_id`),
  KEY `crypto_id` (`crypto_id`),
  KEY `exchange_id` (`exchange_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`portfolio_id`) REFERENCES `Portfolio` (`portfolio_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`crypto_id`) REFERENCES `Cryptocurrency` (`crypto_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transaction_ibfk_4` FOREIGN KEY (`exchange_id`) REFERENCES `Exchange` (`exchange_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,1,1,1,1,'2023-06-21',3.00000000,'BUY',30000.00),(2,1,1,2,3,'2023-06-21',4.00000000,'BUY',2000.00),(3,1,1,13,48,'2023-06-21',10.00000000,'BUY',80.00),(4,1,1,1,3,'2023-06-21',1.00000000,'SELL',40000.00),(5,1,1,2,48,'2023-06-21',2.00000000,'SELL',2500.00),(6,1,1,13,1,'2023-06-21',4.00000000,'SELL',50.00),(7,1,2,4,2,'2023-06-21',1000.00000000,'BUY',1.00),(8,1,2,5,14,'2023-06-21',10000.00000000,'BUY',0.30),(9,1,2,8,10,'2023-06-21',5000.00000000,'BUY',2.00),(10,1,2,4,10,'2023-06-21',500.00000000,'SELL',1.00),(11,1,2,5,2,'2023-06-21',5000.00000000,'SELL',0.50),(12,1,2,8,14,'2023-06-21',2000.00000000,'SELL',1.00),(13,2,3,3,3,'2023-06-21',5.00000000,'BUY',200.00),(14,2,3,7,1,'2023-06-21',10000.00000000,'BUY',0.50),(15,2,3,9,10,'2023-06-21',50.00000000,'BUY',20.00),(16,2,3,3,1,'2023-06-21',2.00000000,'SELL',300.00),(17,2,3,7,3,'2023-06-21',5000.00000000,'SELL',0.45),(18,2,3,9,10,'2023-06-21',40.00000000,'SELL',30.00),(19,2,4,11,15,'2023-06-21',10.00000000,'BUY',300.00),(20,2,4,19,9,'2023-06-21',1000000.00000000,'BUY',0.00),(21,2,4,15,13,'2023-06-21',10000.00000000,'BUY',2.00),(22,2,4,11,13,'2023-06-21',5.00000000,'SELL',350.00),(23,2,4,19,9,'2023-06-21',500000.00000000,'SELL',0.00),(24,2,4,15,15,'2023-06-21',5000.00000000,'SELL',4.00);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email_id` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'John','Doe','john.doe@example.com','johnpassword'),(2,'Jane','Doe','jane.doe@example.com','janepassword');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserCryptocurrency`
--

DROP TABLE IF EXISTS `UserCryptocurrency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserCryptocurrency` (
  `ownership_id` int NOT NULL AUTO_INCREMENT,
  `quantity` decimal(18,8) NOT NULL,
  `current_value` decimal(18,2) NOT NULL,
  `user_id` int DEFAULT NULL,
  `crypto_id` int DEFAULT NULL,
  `portfolio_id` int DEFAULT NULL,
  PRIMARY KEY (`ownership_id`),
  KEY `user_id` (`user_id`),
  KEY `crypto_id` (`crypto_id`),
  KEY `portfolio_id` (`portfolio_id`),
  CONSTRAINT `usercryptocurrency_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usercryptocurrency_ibfk_2` FOREIGN KEY (`crypto_id`) REFERENCES `Cryptocurrency` (`crypto_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `usercryptocurrency_ibfk_3` FOREIGN KEY (`portfolio_id`) REFERENCES `Portfolio` (`portfolio_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserCryptocurrency`
--

LOCK TABLES `UserCryptocurrency` WRITE;
/*!40000 ALTER TABLE `UserCryptocurrency` DISABLE KEYS */;
INSERT INTO `UserCryptocurrency` VALUES (1,2.00000000,80000.00,1,1,1),(2,2.00000000,5000.00,1,2,1),(3,6.00000000,300.00,1,13,1),(4,500.00000000,500.00,1,4,2),(5,5000.00000000,2500.00,1,5,2),(6,3000.00000000,3000.00,1,8,2),(7,3.00000000,900.00,2,3,3),(8,5000.00000000,2250.00,2,7,3),(9,10.00000000,300.00,2,9,3),(10,5.00000000,1750.00,2,11,4),(11,500000.00000000,0.00,2,19,4),(12,5000.00000000,20000.00,2,15,4);
/*!40000 ALTER TABLE `UserCryptocurrency` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_usercryptocurrency_update` AFTER UPDATE ON `usercryptocurrency` FOR EACH ROW BEGIN
    DECLARE portfolio_value DECIMAL(18, 2);

    -- Calculate the total value
    SELECT SUM(current_value) INTO portfolio_value
    FROM UserCryptocurrency
    WHERE user_id = NEW.user_id AND portfolio_id = NEW.portfolio_id;

    -- Update the total value in Portfolio
    UPDATE Portfolio
    SET total_value = portfolio_value
    WHERE user_id = NEW.user_id AND portfolio_id = NEW.portfolio_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `UserPreferences`
--

DROP TABLE IF EXISTS `UserPreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserPreferences` (
  `preference_id` int NOT NULL AUTO_INCREMENT,
  `preferred_currency` varchar(10) NOT NULL,
  `notification_frequency` varchar(20) NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`preference_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `userpreferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserPreferences`
--

LOCK TABLES `UserPreferences` WRITE;
/*!40000 ALTER TABLE `UserPreferences` DISABLE KEYS */;
INSERT INTO `UserPreferences` VALUES (1,'USD','Daily',1),(2,'GBP','Weekly',1),(3,'INR','Weekly',2),(4,'EUR','Monthly',2);
/*!40000 ALTER TABLE `UserPreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Wallet`
--

DROP TABLE IF EXISTS `Wallet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Wallet` (
  `wallet_id` int NOT NULL AUTO_INCREMENT,
  `wallet_address` varchar(100) NOT NULL,
  `wallet_type` varchar(50) NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`wallet_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `wallet_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Wallet`
--

LOCK TABLES `Wallet` WRITE;
/*!40000 ALTER TABLE `Wallet` DISABLE KEYS */;
INSERT INTO `Wallet` VALUES (1,'0x8472947493','digital',1),(2,'0x52748393','physical',2);
/*!40000 ALTER TABLE `Wallet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'crypto_portfolio'
--

--
-- Dumping routines for database 'crypto_portfolio'
--
/*!50003 DROP FUNCTION IF EXISTS `LoginUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `LoginUser`(
p_email_id VARCHAR(100),
p_password VARCHAR(100)) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE v_user_id INT;

    SELECT user_id INTO v_user_id 
    FROM User
    WHERE email_id = p_email_id AND password = p_password;

    IF v_user_id IS NULL THEN
        RETURN 0;
    ELSE 
        RETURN v_user_id;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BuyTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuyTransaction`(
    IN p_user_id INT,
    IN p_portfolio_id INT,
    IN p_crypto_id INT,
    IN p_exchange_id INT,
	IN p_transaction_date DATE,
    IN p_purchase_price DECIMAL(18, 2),
    IN p_quantity DECIMAL(18, 8)
)
BEGIN
    -- Add the transaction
    INSERT INTO transaction(user_id, portfolio_id, crypto_id,exchange_id, transaction_date, quantity, transaction_type, price)
    VALUES(p_user_id, p_portfolio_id, p_crypto_id, p_exchange_id, p_transaction_date, p_quantity, 'BUY', p_purchase_price);
    
   
    -- Update the quantity of cryptocurrency the user owns
    UPDATE UserCryptocurrency
    SET quantity = quantity + p_quantity
    WHERE user_id = p_user_id AND crypto_id = p_crypto_id AND portfolio_id = p_portfolio_id;
    
    
    IF ROW_COUNT() = 0 THEN
        INSERT INTO UserCryptocurrency(user_id, crypto_id, portfolio_id, quantity, current_value)
		VALUES(p_user_id, p_crypto_id, p_portfolio_id, p_quantity, p_purchase_price);

    END IF;
	
    -- Update the current_value of cryptocurrency the user owns
	UPDATE UserCryptocurrency
    SET current_value = quantity * p_purchase_price
	WHERE user_id = p_user_id AND crypto_id = p_crypto_id AND portfolio_id = p_portfolio_id;
    
    -- Insert into CryptoExchange if the pair does not exist already
    INSERT IGNORE INTO CryptoExchange(crypto_id, exchange_id)
    VALUES(p_crypto_id, p_exchange_id);
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreatePortfolio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreatePortfolio`(
IN p_user_id INT,
IN p_portfolio_name VARCHAR(50))
BEGIN
    INSERT INTO Portfolio(portfolio_name, total_value, user_id)
    VALUES(p_portfolio_name, 0.00, p_user_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteProfile` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteProfile`(IN userid INT)
BEGIN
    DELETE FROM User WHERE user_id = userid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertWallet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertWallet`(IN in_wallet_address VARCHAR(255), IN in_wallet_type VARCHAR(255), IN in_user_id INT)
BEGIN
    INSERT INTO Wallet (wallet_address, wallet_type, user_id) 
    VALUES (in_wallet_address, in_wallet_type, in_user_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RegisterUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegisterUser`(
IN p_first_name VARCHAR(50),
IN p_last_name VARCHAR(50),
IN p_email_id VARCHAR(100),
IN p_password VARCHAR(100))
BEGIN
    DECLARE email_exists INT DEFAULT 0;

    SELECT COUNT(*) INTO email_exists
    FROM User
    WHERE email_id = p_email_id;

    IF email_exists = 0 THEN
        INSERT INTO User(first_name, last_name, email_id, password)
        VALUES(p_first_name, p_last_name, p_email_id, p_password);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This email id is already registered.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SellTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SellTransaction`(
    IN p_user_id INT,
    IN p_portfolio_id INT,
    IN p_crypto_id INT,
    IN p_exchange_id INT,
    IN p_transaction_date DATE,
	IN p_sale_price DECIMAL(18, 2),
    IN p_quantity DECIMAL(18, 8)
)
BEGIN
	
    DECLARE user_owns_crypto INT;
    DECLARE user_crypto_quantity DECIMAL(18, 8);
    
    -- Check if the user owns the cryptocurrency
    SELECT COUNT(*) INTO user_owns_crypto
    FROM UserCryptocurrency
    WHERE user_id = p_user_id AND crypto_id = p_crypto_id AND portfolio_id = p_portfolio_id;

    IF user_owns_crypto = 0 THEN
        -- If user does not own the crypto, terminate the procedure
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot sell crypto. Crypto not owned.';
    ELSE
        -- If the user owns the crypto, get the quantity
        SELECT quantity INTO user_crypto_quantity
        FROM UserCryptocurrency
        WHERE user_id = p_user_id AND crypto_id = p_crypto_id AND portfolio_id = p_portfolio_id;

        -- If user does not have enough quantity, terminate the procedure
        IF user_crypto_quantity < p_quantity THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot sell crypto. Not enough quantity owned.';
        ELSE
            -- Add the transaction
            INSERT INTO transaction(user_id, portfolio_id, crypto_id, exchange_id, transaction_date, quantity, transaction_type, price)
            VALUES(p_user_id, p_portfolio_id, p_crypto_id, p_exchange_id, p_transaction_date, p_quantity, 'SELL', p_sale_price);
            
            -- Update the quantity of cryptocurrency the user owns
            UPDATE UserCryptocurrency
            SET quantity = quantity - p_quantity
            WHERE user_id = p_user_id AND crypto_id = p_crypto_id AND portfolio_id = p_portfolio_id;
			
            -- Update the current_value of cryptocurrency the user owns
            UPDATE UserCryptocurrency
            SET current_value = quantity * p_sale_price
            WHERE user_id = p_user_id AND crypto_id = p_crypto_id AND portfolio_id = p_portfolio_id;
            
            -- Insert into CryptoExchange if the pair does not exist already
            INSERT IGNORE INTO CryptoExchange(crypto_id, exchange_id)
            VALUES(p_crypto_id, p_exchange_id);
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetAlert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetAlert`(
    IN p_user_id INT,
    IN p_crypto_id INT,
    IN p_alert_type VARCHAR(50),
    IN p_threshold_value DECIMAL(18, 2)
)
BEGIN
    IF EXISTS (SELECT * FROM Alerts WHERE user_id = p_user_id AND crypto_id = p_crypto_id AND alert_type = p_alert_type) THEN
        UPDATE Alerts 
        SET threshold_value = p_threshold_value 
        WHERE user_id = p_user_id AND crypto_id = p_crypto_id AND alert_type = p_alert_type;
    ELSE
        INSERT INTO Alerts(user_id, crypto_id, alert_type, threshold_value)
        VALUES(p_user_id, p_crypto_id, p_alert_type, p_threshold_value);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SetUserPreferences` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SetUserPreferences`(
IN p_user_id INT,
IN p_preferred_currency VARCHAR(10),
IN p_notification_frequency VARCHAR(20))
BEGIN
    INSERT INTO UserPreferences(user_id, preferred_currency, notification_frequency)
    VALUES(p_user_id, p_preferred_currency, p_notification_frequency)
    ON DUPLICATE KEY UPDATE 
        preferred_currency = p_preferred_currency,
        notification_frequency = p_notification_frequency;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TotalCost` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TotalCost`(IN userid INT, IN portfolioname VARCHAR(255), OUT total_cost DECIMAL(20, 2))
BEGIN
    SELECT COALESCE(SUM(T.quantity * T.price), 0)
    INTO total_cost
    FROM transaction T
    INNER JOIN Portfolio P ON T.portfolio_id = P.portfolio_id
    WHERE T.transaction_type = 'BUY'
    AND T.user_id = userid
    AND P.portfolio_name = portfolioname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TotalSales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TotalSales`(IN userid INT, IN portfolioname VARCHAR(255), OUT total_sales DECIMAL(20, 2))
BEGIN
    SELECT COALESCE(SUM(T.quantity * T.price), 0)
    INTO total_sales
    FROM transaction T
    INNER JOIN Portfolio P ON T.portfolio_id = P.portfolio_id
    WHERE T.transaction_type = 'SELL'
    AND T.user_id = userid
    AND P.portfolio_name = portfolioname;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewAlerts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewAlerts`(IN in_user_id INT)
BEGIN
    SELECT Cryptocurrency.crypto_name, Alerts.alert_type, Alerts.threshold_value 
    FROM Alerts 
    INNER JOIN Cryptocurrency ON Alerts.crypto_id = Cryptocurrency.crypto_id 
    WHERE Alerts.user_id = in_user_id
    ORDER BY Alerts.alert_id DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewPortfolio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewPortfolio`(IN in_user_id INT, IN in_portfolio_name VARCHAR(255))
BEGIN
    SELECT P.portfolio_name, P.total_value, 
           GROUP_CONCAT(C.crypto_name ORDER BY C.crypto_name) AS cryptocurrencies,
           GROUP_CONCAT(UC.quantity ORDER BY C.crypto_name) AS quantities,
           GROUP_CONCAT(UC.current_value ORDER BY C.crypto_name) AS current_values
    FROM Portfolio P
    INNER JOIN UserCryptocurrency UC ON P.user_id = UC.user_id AND P.portfolio_id = UC.portfolio_id
    INNER JOIN Cryptocurrency C ON UC.crypto_id = C.crypto_id
    WHERE P.user_id = in_user_id AND P.portfolio_name = in_portfolio_name
    GROUP BY P.portfolio_name, P.total_value;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewTransactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewTransactions`(IN userid INT)
BEGIN
    SELECT P.portfolio_name, T.transaction_date, T.transaction_type, C.crypto_name, T.quantity, T.price, E.exchange_name
    FROM transaction T
    INNER JOIN cryptocurrency C ON T.crypto_id = C.crypto_id
    INNER JOIN portfolio P ON T.portfolio_id = P.portfolio_id
    INNER JOIN exchange E ON T.exchange_id = E.exchange_id
    WHERE T.user_id = userid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewUserPreferences` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewUserPreferences`(IN in_user_id INT)
BEGIN
    SELECT preferred_currency, notification_frequency 
    FROM UserPreferences 
    WHERE user_id = in_user_id 
    ORDER BY preference_id DESC 
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ViewWallet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewWallet`(IN userid INT)
BEGIN
    SELECT wallet_address, wallet_type
    FROM Wallet
    WHERE user_id = userid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-21 15:34:28
