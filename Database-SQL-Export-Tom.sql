-- MySQL dump 10.13  Distrib 9.4.0, for macos15.4 (arm64)
--
-- Host: localhost    Database: charityevents_db
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(200) NOT NULL,
  `category_desc` varchar(255) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Fun Run','Community fun run for fundraising'),(2,'Gala','Formal dinner and charity event'),(3,'Auction','Live charity auction'),(4,'Concert','Live music ensemble');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donation`
--

DROP TABLE IF EXISTS `donation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donation` (
  `donation_id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `donation_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`donation_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `donation_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donation`
--

LOCK TABLES `donation` WRITE;
/*!40000 ALTER TABLE `donation` DISABLE KEYS */;
INSERT INTO `donation` VALUES (1,1,3000.00),(2,2,500.00),(3,3,10000.00),(4,4,100.00),(5,5,100000.00),(6,6,1500.50),(7,7,1800.20),(8,8,10000.00);
/*!40000 ALTER TABLE `donation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `org_id` int NOT NULL,
  `category_id` int NOT NULL,
  `event_name` varchar(255) NOT NULL,
  `event_desc` text NOT NULL,
  `event_start_dt` datetime NOT NULL,
  `event_end_dt` datetime NOT NULL,
  `location_city` varchar(100) NOT NULL,
  `location_state` varchar(50) NOT NULL,
  `location_postcode` varchar(20) NOT NULL,
  `location_country` varchar(50) NOT NULL DEFAULT 'Australia',
  `goal_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`event_id`),
  KEY `org_id` (`org_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organisation` (`org_id`),
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,1,1,'Bellbrook to Crescent Head Fun Run','A combined 88km fun run from the Country to the Surf.','2025-10-25 10:00:00','2025-10-25 18:00:00','Bellbrook','NSW','2440','Australia',100000.00),(2,2,4,'Charity Concert with Guy Sebastian','A night in concert at Port Macquarie Glasshouse with Guy Sebastian, raising much needed funds for Hat Head Landcare.','2025-10-27 19:00:00','2025-10-27 22:00:00','Port Macquarie','NSW','2440','Australia',50000.00),(3,3,2,'Gala Dinner at the Slim Dusty Centre','Gala dinner, entertainment and speakers to support young people with mental health challenges.','2025-10-29 18:00:00','2025-10-29 22:00:00','Kempsey South','NSW','2440','Australia',15000.00),(4,4,3,'Artwork Auction at Crescent Head SLSC','Artwork auction to raise vital funds for Crescent Head Beach Care.','2025-10-23 12:00:00','2025-10-23 14:30:00','Crescent Head','NSW','2440','Australia',3000.00),(5,5,3,'Sculpture Auction to Support our Flood Victims','Sculpture auction to support our flood affected communities.','2025-10-30 18:30:00','2025-10-30 20:00:00','Kempsey West','NSW','2440','Australia',1200.00),(6,6,4,'Local Artists Concert to Raise Funds for Arts MNC!','Bandbox Theatre concert featuring Mid-North Coast Local Artists to raise funds for Arts Mid-North Coast.','2025-11-02 19:30:00','2025-11-02 21:30:00','Kempsey West','NSW','2440','Australia',5000.00),(7,7,2,'Gala Dinner at the Kempsey Macleay RSL Club','Gala dinner at the Kempsey Macleay RSL Club to increase public transport on the North Coast.','2025-11-05 18:00:00','2025-11-05 20:30:00','Kempsey','NSW','2440','Australia',5500.00),(8,8,1,'Kempsey Fun Run to Improve the Macleay','Kempsey fun run along the Eden Street Parklands to improve the Macleay Valley!','2025-11-10 09:00:00','2025-11-10 12:00:00','Kempsey','NSW','2440','Australia',12000.00);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_category`
--

DROP TABLE IF EXISTS `event_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_category`
--

LOCK TABLES `event_category` WRITE;
/*!40000 ALTER TABLE `event_category` DISABLE KEYS */;
INSERT INTO `event_category` VALUES (6,'Art Exhibition'),(4,'Benefit Concert'),(8,'Charity Ball'),(5,'Community BBQ'),(1,'Fun Run'),(2,'Gala Dinner'),(10,'Movie Night Fundraiser'),(3,'Silent Auction'),(7,'Trivia Night'),(9,'Walkathon');
/*!40000 ALTER TABLE `event_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organisation`
--

DROP TABLE IF EXISTS `organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organisation` (
  `org_id` int NOT NULL AUTO_INCREMENT,
  `org_name` varchar(200) NOT NULL,
  `org_welcome_message` text NOT NULL,
  `org_mission_statement` text NOT NULL,
  `org_website` varchar(200) NOT NULL,
  `org_phone` varchar(20) NOT NULL,
  `org_email` varchar(200) NOT NULL,
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organisation`
--

LOCK TABLES `organisation` WRITE;
/*!40000 ALTER TABLE `organisation` DISABLE KEYS */;
INSERT INTO `organisation` VALUES (1,'Macleay Valley Rail Ltd','Welcome to Macleay Valley Rail Ltd','Introducing trains to our Macleay Valley Communities','www.macleayvalleyrail.com.au','0422 044 712','admin@macleayvalleyrail.com.au'),(2,'Hat Head Landcare','Welcome to Hat Head Landcare','Planting one tree at a time','www.hhlc.org.au','0400 008 754','contact@hhlc.org.au'),(3,'Lifeline Mid Coast','Welcome to Lifeline Mid Coast','Caring for our most vulnerable','www.lifelinemidcoast.org.au','02 6562 1346','admin@lifelinemidcoast.org.au'),(4,'Crescent Head Beach Care','Welcome to Crescent Head Beach Care','Caring for our pristine coastline!','www.chbc.org.au','0476 553 221','chbc@chbc.org.au'),(5,'Gowings Foundation','Welcome to Gowings Foundation','Caring for our Mid-North Coast communities','www.gowings.com.au','1300 800 500','info@gowings.com.au'),(6,'Arts Mid North Coast','Welcome to Arts Mid North Coast','Getting arts back into the MNC!','www.artsmidnorthcoast.com','0400 443 862','contact@artsmidnorthcoast.com'),(7,'Carpenter Foundation','Welcome to the Carpenter Foundation','Improving access for young people on the North Coast','www.carpenterfoundation.com','0488 774 221','contact@carpenterfoundation.com'),(8,'Macleay Valley Revitalisation Project','Welcome to the MVRP!','Improving the Macleay Valley, one step at a time','www.mvrp.org.au','0422 334 113','info@mvrp.org.au');
/*!40000 ALTER TABLE `organisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration` (
  `reg_id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `contact_email` varchar(150) NOT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `tickets_purchased` int unsigned NOT NULL,
  `registration_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `registration_ref` varchar(40) NOT NULL,
  PRIMARY KEY (`reg_id`),
  UNIQUE KEY `uniq_registration_ref` (`registration_ref`),
  UNIQUE KEY `registration_ref` (`registration_ref`),
  UNIQUE KEY `unique_event_registration` (`event_id`,`contact_email`),
  CONSTRAINT `fk_registration_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration`
--

LOCK TABLES `registration` WRITE;
/*!40000 ALTER TABLE `registration` DISABLE KEYS */;
INSERT INTO `registration` VALUES (13,1,'Emily','Carter','emily.carter@example.com','0412 345 678',2,'2025-07-01 10:15:00','EVT0001-A9F4B2'),(14,1,'James','Wilson','james.wilson@example.com','0428 556 789',1,'2025-07-03 14:22:00','EVT0001-CC3E91'),(15,1,'Sarah','Nguyen','sarah.nguyen@example.com','0439 112 478',3,'2025-07-06 09:05:00','EVT0001-F3A7D4'),(16,1,'Benjamin','Foster','ben.foster@example.com','0401 778 334',1,'2025-07-08 18:10:00','EVT0001-4B91E8'),(17,1,'Hannah','Scott','hannah.scott@example.com','0450 667 238',2,'2025-07-10 16:42:00','EVT0001-8D12A7'),(18,1,'Daniel','Price','daniel.price@example.com','0418 234 556',1,'2025-07-12 11:33:00','EVT0001-5E7F2C'),(19,1,'Lucy','Martin','lucy.martin@example.com','0425 909 887',2,'2025-07-14 08:29:00','EVT0001-BE9D60'),(20,1,'William','Moore','will.moore@example.com','0430 725 441',1,'2025-07-15 12:50:00','EVT0001-19C4A3'),(21,1,'Sophie','Adams','sophie.adams@example.com','0407 633 298',1,'2025-07-17 09:17:00','EVT0001-7A4FB1'),(22,1,'Jacob','Reed','jacob.reed@example.com','0413 876 920',2,'2025-07-19 15:20:00','EVT0001-E84D5F'),(23,2,'Harper','Kelly','harper.kelly@example.com','0410 244 998',2,'2025-07-11 11:10:00','EVT0002-4FD9C1'),(24,2,'Mason','Young','mason.young@example.com','0416 789 345',1,'2025-07-12 15:55:00','EVT0002-2E3A9B'),(25,2,'Zoe','Rogers','zoe.rogers@example.com','0438 990 221',3,'2025-07-13 10:28:00','EVT0002-9B7D3E'),(26,2,'Ethan','Murphy','ethan.murphy@example.com','0403 668 917',1,'2025-07-15 12:40:00','EVT0002-CCF0E6'),(27,2,'Layla','Richardson','layla.richardson@example.com','0467 550 210',2,'2025-07-17 08:15:00','EVT0002-13AC58'),(28,2,'Aiden','Bailey','aiden.bailey@example.com','0455 331 749',1,'2025-07-18 14:42:00','EVT0002-705F9E'),(29,2,'Sienna','Harris','sienna.harris@example.com','0432 782 002',3,'2025-07-20 19:11:00','EVT0002-8BC6D2'),(30,2,'Liam','Wright','liam.wright@example.com','0419 623 451',2,'2025-07-22 13:54:00','EVT0002-DF1B47'),(31,2,'Isla','King','isla.king@example.com','0420 441 972',1,'2025-07-24 18:09:00','EVT0002-62F9E4'),(32,2,'Henry','Ward','henry.ward@example.com','0405 994 833',2,'2025-07-26 10:47:00','EVT0002-BA70CD'),(33,3,'Scarlett','Adams','scarlett.adams@example.com','0438 654 119',2,'2025-07-09 09:34:00','EVT0003-42EACF'),(34,3,'Ryan','Hughes','ryan.hughes@example.com','0450 877 923',1,'2025-07-12 16:20:00','EVT0003-A0C9D5'),(35,3,'Ella','Parker','ella.parker@example.com','0402 339 101',3,'2025-07-15 11:49:00','EVT0003-71BE92'),(36,3,'Charlie','Davis','charlie.davis@example.com','0426 877 812',2,'2025-07-18 10:05:00','EVT0003-1E8F4A'),(37,3,'Sophie','Hill','sophie.hill@example.com','0413 332 888',2,'2025-07-20 08:50:00','EVT0003-6B3DAE'),(38,3,'Nathan','Scott','nathan.scott@example.com','0408 211 522',1,'2025-07-22 15:12:00','EVT0003-98FC40'),(39,3,'Grace','Johnson','grace.johnson@example.com','0435 554 337',3,'2025-07-25 12:36:00','EVT0003-5C2A1B'),(40,3,'Leo','Carter','leo.carter@example.com','0416 728 006',2,'2025-07-27 09:29:00','EVT0003-CE7D84'),(41,3,'Chloe','White','chloe.white@example.com','0451 120 678',2,'2025-07-29 10:44:00','EVT0003-F9B6E3'),(42,3,'Ethan','Murphy','ethan.murphy2@example.com','0423 554 772',1,'2025-07-31 16:03:00','EVT0003-0A1C75'),(43,4,'Asha','Khan','asha.khan@example.com','0411 555 123',1,'2025-07-05 10:00:00','EVT0004-B8A0C2'),(44,4,'Owen','Reid','owen.reid@example.com','0427 333 444',2,'2025-07-07 12:15:00','EVT0004-7E1F93'),(45,4,'Maya','Patel','maya.patel@example.com','0436 222 111',1,'2025-07-09 16:05:00','EVT0004-99E2A5'),(46,4,'Connor','Brooks','connor.brooks@example.com','0404 999 888',2,'2025-07-11 09:30:00','EVT0004-4C7BE0'),(47,4,'Zoe','Hughes','zoe.hughes@example.com','0455 121 314',1,'2025-07-13 11:20:00','EVT0004-12CF8B'),(48,4,'Mitchell','Ross','mitchell.ross@example.com','0422 444 555',2,'2025-07-15 14:55:00','EVT0004-F07A63'),(49,4,'Poppy','Green','poppy.green@example.com','0417 210 999',1,'2025-07-17 08:45:00','EVT0004-AC5E41'),(50,4,'Isaac','Bell','isaac.bell@example.com','0431 778 200',2,'2025-07-19 13:00:00','EVT0004-58D0EE'),(51,4,'Nora','Fisher','nora.fisher@example.com','0406 121 999',1,'2025-07-21 17:10:00','EVT0004-DFB9A2'),(52,4,'Eli','Foster','eli.foster@example.com','0429 555 333',1,'2025-07-23 09:05:00','EVT0004-62EA3D'),(53,5,'Zachary','Ford','zachary.ford@example.com','0412 000 111',1,'2025-07-02 08:25:00','EVT0005-BF3C87'),(54,5,'Luna','Reeves','luna.reeves@example.com','0421 111 222',2,'2025-07-04 12:40:00','EVT0005-E80D56'),(55,5,'Ava','Mason','ava.mason@example.com','0433 333 444',1,'2025-07-06 15:12:00','EVT0005-76AB94'),(56,5,'Omar','Hassan','omar.hassan@example.com','0407 444 555',2,'2025-07-08 09:50:00','EVT0005-3E2F1D'),(57,5,'Leah','Barnes','leah.barnes@example.com','0456 555 666',1,'2025-07-10 11:30:00','EVT0005-97A6B2'),(58,5,'Callum','Peters','callum.peters@example.com','0413 222 333',2,'2025-07-12 17:05:00','EVT0005-DC41E9'),(59,5,'Iris','Wood','iris.wood@example.com','0423 444 555',3,'2025-07-14 09:15:00','EVT0005-21F0C3'),(60,5,'Marcus','Bell','marcus.bell@example.com','0434 555 666',1,'2025-07-16 14:40:00','EVT0005-AE7D5F'),(61,5,'Tia','Harper','tia.harper@example.com','0401 333 444',2,'2025-07-18 10:05:00','EVT0005-4F90A8'),(62,5,'Dylan','Parker','dylan.parker@example.com','0428 666 777',1,'2025-07-20 16:10:00','EVT0005-EB3D6C'),(63,6,'Mason','Black','mason.black@example.com','0412 444 555',2,'2025-07-21 10:10:00','EVT0006-1EFA97'),(64,6,'Chloe','Hunt','chloe.hunt@example.com','0426 777 888',1,'2025-07-23 13:20:00','EVT0006-CC4B60'),(65,6,'Noah','Myers','noah.myers@example.com','0430 222 999',3,'2025-07-25 09:00:00','EVT0006-85E2DA'),(66,6,'Zoe','Foster','zoe.foster@example.com','0409 111 000',1,'2025-07-27 18:30:00','EVT0006-3F6C2B'),(67,6,'Lachlan','Reid','lachlan.reid@example.com','0451 555 444',2,'2025-07-29 12:05:00','EVT0006-A74D8F'),(68,6,'Aisha','Murphy','aisha.murphy@example.com','0417 222 333',1,'2025-07-31 16:40:00','EVT0006-EE2A10'),(69,6,'Harry','Nash','harry.nash@example.com','0424 999 111',2,'2025-08-02 08:48:00','EVT0006-7C3F9B'),(70,6,'Penny','Rowe','penny.rowe@example.com','0435 666 777',1,'2025-08-04 11:27:00','EVT0006-2BE69D'),(71,6,'Evan','Price','evan.price@example.com','0403 222 333',2,'2025-08-06 14:36:00','EVT0006-F84A72'),(72,6,'Zara','King','zara.king@example.com','0420 223 444',1,'2025-08-08 09:19:00','EVT0006-94CBE5'),(73,7,'Isabella','Ford','isabella.ford@example.com','0412 121 212',2,'2025-07-26 09:00:00','EVT0007-7DA9F3'),(74,7,'Samuel','Knight','samuel.knight@example.com','0428 343 343',1,'2025-07-28 11:30:00','EVT0007-30C5B7'),(75,7,'Keira','Mills','keira.mills@example.com','0439 454 454',3,'2025-07-30 14:22:00','EVT0007-AC18E2'),(76,7,'Daniela','Costa','daniela.costa@example.com','0401 565 565',1,'2025-08-01 16:12:00','EVT0007-EF7B4D'),(77,7,'Riley','Campbell','riley.campbell@example.com','0455 676 676',2,'2025-08-03 10:05:00','EVT0007-12B6F8'),(78,7,'Noel','Anderson','noel.anderson@example.com','0419 787 787',1,'2025-08-05 13:33:00','EVT0007-B8C1E0'),(79,7,'Maya','Ellis','maya.ellis@example.com','0432 898 898',2,'2025-08-07 09:44:00','EVT0007-59AEE9'),(80,7,'Freya','Harrison','freya.harrison@example.com','0408 909 909',1,'2025-08-09 17:20:00','EVT0007-C2D954'),(81,7,'Cooper','Baxter','cooper.baxter@example.com','0423 111 000',2,'2025-08-11 12:00:00','EVT0007-3E4F19'),(82,7,'Asha','Morgan','asha.morgan@example.com','0450 222 111',1,'2025-08-13 15:31:00','EVT0007-F1A76C'),(83,8,'Grace','Taylor','grace.taylor@example.com','0412 345 123',1,'2025-07-03 09:45:00','EVT0008-43BDAE'),(84,8,'Eli','Baker','eli.baker@example.com','0429 555 333',2,'2025-07-05 13:05:00','EVT0008-CA91F0'),(85,8,'Phoebe','Moss','phoebe.moss@example.com','0406 777 222',1,'2025-07-07 10:15:00','EVT0008-91E6B3'),(86,8,'Aaron','Frost','aaron.frost@example.com','0423 111 888',2,'2025-07-09 16:00:00','EVT0008-19CF84'),(87,8,'Clara','Brooks','clara.brooks@example.com','0434 999 666',1,'2025-07-11 11:12:00','EVT0008-8BE5DA'),(88,8,'Hugo','Turner','hugo.turner@example.com','0407 333 999',3,'2025-07-13 17:10:00','EVT0008-F25C3B'),(89,8,'Mila','Waters','mila.waters@example.com','0452 444 777',2,'2025-07-15 09:58:00','EVT0008-26A9E1'),(90,8,'Louis','Chapman','louis.chapman@example.com','0415 555 000',1,'2025-07-17 14:40:00','EVT0008-7FE03C'),(91,8,'Sasha','Ward','sasha.ward@example.com','0428 666 444',2,'2025-07-19 10:25:00','EVT0008-9C8D5A'),(92,8,'Nina','Wells','nina.wells@example.com','0439 777 111',1,'2025-07-21 12:10:00','EVT0008-EB47D9');
/*!40000 ALTER TABLE `registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `event_id` int NOT NULL,
  `ticket_price` decimal(4,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`ticket_id`),
  KEY `event_id` (`event_id`),
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,1,20.00),(2,2,65.00),(3,3,95.00),(4,4,5.00),(5,5,10.00),(6,6,30.00),(7,7,80.00),(8,8,15.50);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-05 19:29:58
