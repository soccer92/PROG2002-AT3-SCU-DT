-- MySQL dump 10.13  Distrib 8.0.43, for macos15 (arm64)
--
-- Host: localhost    Database: charityevents_db
-- ------------------------------------------------------
-- Server version	8.4.6

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,1,1,'Bellbrook to Crescent Head Fun Run','A combined 88km fun run from the Country to the Surf.','2025-10-15 10:00:00','2025-10-15 18:00:00','Bellbrook','NSW','2440','Australia',100000.00),(2,2,4,'Charity Concert with Guy Sebastian','A night in concert at Port Macquarie Glasshouse with Guy Sebastian, raising much needed funds for Hat Head Landcare.','2025-10-04 19:00:00','2025-10-04 22:00:00','Port Macquarie','NSW','2440','Australia',50000.00),(3,3,2,'Gala Dinner at the Slim Dusty Centre','Gala dinner, entertainment and speakers to support young people with mental health challenges.','2025-10-01 18:00:00','2025-10-01 22:00:00','Kempsey South','NSW','2440','Australia',15000.00),(4,4,3,'Artwork Auction at Crescent Head SLSC','Artwork auction to raise vital funds for Crescent Head Beach Care.','2025-09-30 12:00:00','2025-09-30 14:30:00','Crescent Head','NSW','2440','Australia',3000.00),(5,5,3,'Sculpture Auction to Support our Flood Victims','Sculpture auction to support our flood affected communities.','2025-09-22 18:30:00','2025-09-22 20:00:00','Kempsey West','NSW','2440','Australia',1200.00),(6,6,4,'Local Artists Concert to Raise Funds for Arts MNC!','Bandbox Theatre concert featuring Mid-North Coast Local Artists to raise funds for Arts Mid-North Coast.','2025-09-27 19:30:00','2025-09-27 21:30:00','Kempsey West','NSW','2440','Australia',5000.00),(7,7,2,'Gala Dinner at the Kempsey Macleay RSL Club','Gala dinner at the Kempsey Macleay RSL Club to increase public transport on the North Coast.','2025-10-12 18:00:00','2025-10-12 20:30:00','Kempsey','NSW','2440','Australia',5500.00),(8,8,1,'Kempsey Fun Run to Improve the Macleay','Kempsey fun run along the Eden Street Parklands to improve the Macleay Valley!','2025-10-01 09:00:00','2025-10-01 12:00:00','Kempsey','NSW','2440','Australia',12000.00);
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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

-- Dump completed on 2025-09-20 13:28:02
