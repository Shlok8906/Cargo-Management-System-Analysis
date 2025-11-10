-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: cargomanagementsystem
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo` (
  `cargo_id` int NOT NULL AUTO_INCREMENT,
  `type` text,
  `weight_kg` float NOT NULL,
  `volume_m3` float NOT NULL,
  `value_usd` float DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  PRIMARY KEY (`cargo_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `cargo_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  CONSTRAINT `cargo_chk_1` CHECK ((`type` in (_utf8mb4'Perishable',_utf8mb4'Fragile',_utf8mb4'Hazardous',_utf8mb4'General')))
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo`
--

LOCK TABLES `cargo` WRITE;
/*!40000 ALTER TABLE `cargo` DISABLE KEYS */;
INSERT INTO `cargo` VALUES (1,'General',805.47,99.11,4901.45,37),(2,'Perishable',902.31,78.74,86407.8,8),(3,'Perishable',1831.28,8.56,23839.2,2),(4,'Perishable',689.57,90.09,53876.5,37),(5,'Hazardous',317.13,6.78,94594.5,39),(6,'Fragile',1284.21,5.15,40331.3,12),(7,'Fragile',911.82,77.16,13721.1,3),(8,'Hazardous',1381.74,7.97,34847.7,21),(9,'Perishable',156.21,77.1,72147.4,30),(10,'General',188.14,39.72,2476.16,9),(11,'General',1132.33,84.64,21867.4,23),(12,'Perishable',895.42,86.82,33518.8,37),(13,'Hazardous',1981.27,98.76,16371.6,27),(14,'Perishable',194.41,82.79,79162,32),(15,'Perishable',1701.47,1.64,47832.8,24),(16,'Perishable',573.41,44.91,72331,8),(17,'Perishable',962.82,85.74,25753.6,27),(18,'Hazardous',1382.48,98.79,31363,20),(19,'Hazardous',458.75,70.63,84522.5,29),(20,'General',236.88,48.06,45596.6,10),(21,'General',1476.56,34.58,83685.7,22),(22,'Perishable',357.71,37.71,24856.1,29),(23,'Perishable',257.04,2.94,80980.8,33),(24,'Fragile',741.6,51.97,65145.1,36),(25,'Fragile',545.25,79.5,44099.1,4),(26,'Hazardous',921.34,49.08,46614.7,8),(27,'General',1685.77,40.28,57311.9,32),(28,'Perishable',1386.48,38.48,80958.6,40),(29,'Fragile',992.79,9.43,28600.1,12),(30,'General',159.79,75.01,44425.6,22),(31,'General',1168.08,76.32,30802.2,25),(32,'Hazardous',1362.22,10.14,35679.9,7),(33,'Fragile',1314.68,25.58,31880.9,21),(34,'Perishable',355.23,9.85,20419.7,16),(35,'General',351.18,10.96,37988.2,18),(36,'Hazardous',1307.56,38.44,95449.3,21),(37,'Hazardous',239.84,28.76,56632.1,39),(38,'Fragile',1813.43,80.56,57433.4,35),(39,'Perishable',1294.86,23.44,18344.8,12),(40,'Hazardous',910.16,48.34,27389.4,29);
/*!40000 ALTER TABLE `cargo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `client_id` int NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `contact_info` text,
  `company_name` text,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Michael Crawford','warnerdanielle@flynn.com','Whitaker, White and Ellison'),(2,'Patrick Shields','suzanne71@gmail.com','Armstrong, Wallace and Marshall'),(3,'Kim Jones','callen@gmail.com','Bates-Abbott'),(4,'Shawn Clark','cwilson@rodriguez.com','Maldonado-Mason'),(5,'Jennifer Cunningham','katrina16@rodriguez.biz','Copeland Inc'),(6,'Philip Duncan','kellysean@nelson.net','Johnson, Frost and Brown'),(7,'Morgan Sharp','cortezjonathan@yahoo.com','Carter PLC'),(8,'Michael Ritter','downsomar@tate-brown.com','Holland-Martinez'),(9,'Amanda Turner','davisrobert@wright.com','Frazier LLC'),(10,'Jennifer Sanchez','johnathan42@blackwell.com','Maynard Group'),(11,'Joseph Hernandez','johnparker@lewis-myers.com','Garcia PLC'),(12,'John Bradley','fernandezkristen@rodriguez.com','Vazquez-Nguyen'),(13,'Thomas Anderson','qday@yahoo.com','Hester, Gallagher and Guerrero'),(14,'Brian Williams PhD','rhondacurtis@salinas-brandt.com','Scott, Hernandez and Watson'),(15,'Emily Moore','derekwhitaker@parker-hood.com','Hopkins, Williams and Anderson'),(16,'Erica Gonzales','danderson@gmail.com','Park, Matthews and Scott'),(17,'Matthew Joyce','emilylarson@ortiz-gonzalez.com','Jones-Richard'),(18,'Ricardo Smith','bmatthews@gmail.com','Bean Ltd'),(19,'Jeremy Patel','zhall@hotmail.com','Morrow-Fisher'),(20,'James Galvan','nedwards@gmail.com','Patterson, Watts and Copeland'),(21,'Michael Wolf','schmidtrobert@hotmail.com','Wilson, Horne and Kelly'),(22,'Krista Lee','dbrady@yahoo.com','Lang and Sons'),(23,'Justin Burns','lesterhoward@sims.com','Ford, Howard and Rodriguez'),(24,'Mary Byrd','nmartin@yahoo.com','Collins-Haley'),(25,'Dawn Lawson','daviszachary@lindsey-glenn.com','Martin-Holmes'),(26,'Trevor Barrera','rebeccajohnson@hotmail.com','Aguilar-Ramirez'),(27,'Mark Roberts','greenesergio@willis-gallagher.org','Ward, Davis and Perkins'),(28,'Vanessa Reed','kkaiser@cunningham-harris.com','Rojas Group'),(29,'Brian Smith','deannavasquez@bishop.info','Burke, Frazier and Fischer'),(30,'Ashley Peterson','galvanmichael@gmail.com','Phillips and Sons'),(31,'Michael Wilson','shammond@yahoo.com','Valencia, Bryant and Riddle'),(32,'Cameron Reed','wardpatrick@yahoo.com','Thomas Ltd'),(33,'Daniel Brennan','sosarebecca@hotmail.com','Morales-Dixon'),(34,'Tiffany Harmon','colleen52@gonzalez-moore.biz','Brown LLC'),(35,'Julia Morrison','ascott@gmail.com','Jones-Chung'),(36,'Sean Chavez','kanderson@yahoo.com','Bradley and Sons'),(37,'Yolanda Blackburn','aaronporter@hotmail.com','Smith Group'),(38,'Mary Harris','irowe@yahoo.com','Greene and Sons'),(39,'Kelly Rodriguez','jennifer46@gmail.com','Campbell Ltd'),(40,'Brandon Estrada','zrivers@garza.biz','Adams PLC');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customs`
--

DROP TABLE IF EXISTS `customs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customs` (
  `customs_id` int NOT NULL AUTO_INCREMENT,
  `shipment_id` int DEFAULT NULL,
  `port` text NOT NULL,
  `clearance_status` enum('Cleared','Pending','On Hold','Rejected') NOT NULL DEFAULT 'Pending',
  `clearance_time_hr` decimal(6,2) DEFAULT NULL,
  `duty_paid` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`customs_id`),
  KEY `shipment_id` (`shipment_id`),
  CONSTRAINT `customs_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`shipment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customs`
--

LOCK TABLES `customs` WRITE;
/*!40000 ALTER TABLE `customs` DISABLE KEYS */;
INSERT INTO `customs` VALUES (1,7,'North Judyview','Pending',36.05,3552.60),(2,1,'Port Andreaside','Pending',28.06,844.44),(3,34,'Marilynberg','Cleared',1.87,2298.44),(4,11,'Lake Robert','Cleared',17.72,2844.52),(5,38,'Ericfurt','Pending',36.23,1729.37),(6,23,'Ryanmouth','On Hold',53.72,3518.49),(7,40,'Jasonburgh','Cleared',21.65,3472.44),(8,30,'East Allison','Pending',37.83,215.36),(9,21,'Lindastad','On Hold',54.88,1285.67),(10,12,'Grayberg','Cleared',3.38,2829.94),(11,25,'Anthonyville','Pending',29.81,3939.52),(12,13,'Mcmillanshire','On Hold',48.48,1053.85),(13,7,'West Matthewstad','Pending',36.12,4108.63),(14,2,'Port Sarahport','On Hold',53.92,3958.57),(15,40,'Clarktown','On Hold',54.84,3437.11),(16,6,'North Christine','Pending',25.68,3516.78),(17,11,'New Leslie','Cleared',15.44,4602.54),(18,28,'Port Colleenmouth','On Hold',63.10,528.68),(19,34,'Barkerborough','On Hold',61.15,2004.25),(20,40,'Brendafurt','On Hold',52.41,423.42),(21,30,'New Amybury','On Hold',67.81,1367.49),(22,15,'Lake Charlesside','Pending',36.97,575.98),(23,25,'Lake Darrelltown','Pending',42.29,2693.57),(24,20,'Donnamouth','Pending',29.91,2266.26),(25,28,'Lake Michael','Pending',26.67,3973.78),(26,29,'Natalieshire','Pending',26.38,240.11),(27,29,'New Monique','Pending',35.43,3768.15),(28,1,'Robbinsbury','Pending',47.47,4100.87),(29,1,'Alexisside','Pending',39.82,1219.90),(30,24,'Sierraview','On Hold',51.59,1031.72),(31,23,'New Francesfort','Cleared',12.67,3270.28),(32,30,'Rogersside','On Hold',71.65,4524.18),(33,24,'New Paulamouth','Cleared',18.86,762.56),(34,39,'Andreamouth','On Hold',63.93,1526.94),(35,16,'Port Michelleburgh','Cleared',19.64,4460.53),(36,34,'Jacquelinemouth','On Hold',56.62,3768.03),(37,33,'Ericbury','On Hold',52.67,201.09),(38,19,'Hendersonside','On Hold',56.71,2704.97),(39,7,'Gabrielberg','Pending',33.61,284.80),(40,30,'Schmidtland','On Hold',56.56,281.66);
/*!40000 ALTER TABLE `customs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `role` text,
  `contact_info` text,
  `warehouse_id` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`),
  CONSTRAINT `employees_chk_1` CHECK ((`role` in (_cp850'Driver',_cp850'Customs Officer',_cp850'Warehouse Staff',_cp850'Manager')))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Dana Cameron','Warehouse Staff','joshuataylor@yahoo.com',11),(2,'Robert Rhodes','Driver','thomastorres@clay-carr.com',3),(3,'John Williams','Customs Officer','ethan12@cox.biz',8),(4,'Jonathan Moody','Driver','nmiller@hotmail.com',5),(5,'Rodney Montgomery','Manager','ricardoritter@yahoo.com',20),(6,'Elizabeth Carlson','Driver','michaelsingh@colon.org',3),(7,'William Robinson','Driver','samantha02@hotmail.com',8),(8,'Adrian Wilson','Warehouse Staff','markjimenez@yahoo.com',13),(9,'Emma Miranda','Customs Officer','christinabest@garcia-smith.com',16),(10,'Jessica Willis','Manager','lisacontreras@gmail.com',3),(11,'Veronica Henderson','Driver','eburton@baker.com',1),(12,'Ricky Branch','Warehouse Staff','qcharles@yahoo.com',1),(13,'Arthur Baker','Customs Officer','rogersjose@gmail.com',9),(14,'Adrienne Nelson','Warehouse Staff','clee@gmail.com',16),(15,'Sandra Smith','Manager','svaldez@hotmail.com',2),(16,'Kevin Wells','Manager','jamie50@yahoo.com',3),(17,'Mark Riley','Customs Officer','bestshelia@gmail.com',18),(18,'Blake Morris','Customs Officer','jordanjennifer@gmail.com',7),(19,'Joshua Horn','Driver','krista89@henry-savage.com',7),(20,'Joanna Huerta','Manager','robinroth@hall.com',2),(21,'Andrew Wiggins','Warehouse Staff','timothy55@sullivan.com',3),(22,'Linda Stewart','Customs Officer','victoria95@stevens.com',34),(23,'Jeffrey Anderson','Customs Officer','peggygonzalez@gmail.com',8),(24,'Whitney Austin','Warehouse Staff','wendybradley@hotmail.com',25),(25,'Derek Mendoza','Driver','julian63@hotmail.com',37),(26,'William Walker','Customs Officer','krista41@welch-vaughan.com',8),(27,'Kayla Ryan','Manager','williamcarrillo@lopez.com',25),(28,'Dawn Knight','Customs Officer','jill59@yahoo.com',27),(29,'Charles Gonzalez','Customs Officer','nicolenelson@gmail.com',40),(30,'Keith Hahn','Manager','gcooper@yahoo.com',15),(31,'Chase Preston','Warehouse Staff','marysmith@yahoo.com',8),(32,'Mr. Travis Fox MD','Warehouse Staff','marshallpamela@hernandez.com',27),(33,'Christopher Woods MD','Customs Officer','rogersamanda@yahoo.com',40),(34,'Sean Nielsen','Warehouse Staff','robinsonchristine@gmail.com',21),(35,'Christopher Carpenter','Driver','jessicawalker@hayes.com',24),(36,'Luke Trujillo','Manager','bgonzalez@gonzalez-sutton.info',3),(37,'Chad Roberts','Driver','cspears@yahoo.com',31),(38,'Jesse Landry','Warehouse Staff','jonathanjohnson@yahoo.com',6),(39,'Rebecca Cain','Manager','russelldeborah@yahoo.com',32),(40,'Dr. Michael Montgomery','Warehouse Staff','sandrapennington@harris.com',14);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insuranceclaims`
--

DROP TABLE IF EXISTS `insuranceclaims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insuranceclaims` (
  `claim_id` int NOT NULL AUTO_INCREMENT,
  `cargo_id` int DEFAULT NULL,
  `client_id` int DEFAULT NULL,
  `claim_amount` float NOT NULL,
  `status` text,
  `filed_at` datetime DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL,
  PRIMARY KEY (`claim_id`),
  KEY `cargo_id` (`cargo_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `insuranceclaims_ibfk_1` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`cargo_id`),
  CONSTRAINT `insuranceclaims_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
  CONSTRAINT `insuranceclaims_chk_1` CHECK ((`status` in (_cp850'Pending',_cp850'Approved',_cp850'Rejected',_cp850'Paid')))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insuranceclaims`
--

LOCK TABLES `insuranceclaims` WRITE;
/*!40000 ALTER TABLE `insuranceclaims` DISABLE KEYS */;
INSERT INTO `insuranceclaims` VALUES (1,28,16,12077.8,'Paid','2025-01-04 12:32:39','2025-02-14 12:32:39'),(2,33,15,13006.6,'Rejected','2025-03-10 15:46:28','2025-06-08 15:46:28'),(3,3,29,7926.6,'Approved','2025-07-20 10:09:17','2025-10-28 10:09:17'),(4,15,11,4835.56,'Paid','2025-06-08 01:49:02','2025-07-22 01:49:02'),(5,19,5,4262.91,'Paid','2024-10-05 15:35:39','2025-01-11 15:35:39'),(6,26,18,18049.8,'Paid','2025-08-16 09:48:41','2025-09-26 09:48:41'),(7,28,2,17250.6,'Rejected','2025-04-11 17:33:52','2025-07-07 17:33:52'),(8,39,9,8356.2,'Approved','2025-07-15 19:52:21','2025-09-07 19:52:21'),(9,15,1,18790.1,'Rejected','2025-08-12 09:15:24','2025-09-06 09:15:24'),(10,9,30,12266.3,'Approved','2024-10-24 14:16:51','2025-01-22 14:16:51'),(11,40,4,1191.88,'Rejected','2025-02-02 00:02:05','2025-03-14 00:02:05'),(12,25,40,9691.24,'Pending','2025-04-09 20:51:23','2025-07-10 20:51:23'),(13,38,24,10098.2,'Approved','2025-01-05 08:49:53','2025-02-11 08:49:53'),(14,6,28,13424.7,'Rejected','2024-10-27 06:37:45','2024-11-07 06:37:45'),(15,33,30,12967.8,'Paid','2024-09-17 18:20:38','2024-12-22 18:20:38'),(16,34,29,6574.06,'Approved','2025-04-14 12:23:46','2025-06-15 12:23:46'),(17,2,14,15164.3,'Paid','2024-09-01 06:01:49','2024-10-19 06:01:49'),(18,12,1,18369.1,'Pending','2024-09-29 03:04:26','2024-11-08 03:04:26'),(19,27,29,15542.1,'Pending','2024-10-19 10:11:33','2025-01-15 10:11:33'),(20,31,24,17078.7,'Rejected','2025-05-17 05:46:01','2025-08-13 05:46:01'),(21,10,21,10175.9,'Rejected','2025-05-06 09:30:54','2025-08-08 09:30:54'),(22,30,38,3673.9,'Paid','2024-09-01 23:05:46','2024-11-27 23:05:46'),(23,24,32,5344.09,'Rejected','2025-04-30 09:37:05','2025-07-22 09:37:05'),(24,35,28,12873.3,'Rejected','2024-10-01 05:07:33','2024-11-30 05:07:33'),(25,29,8,13704.3,'Rejected','2024-12-31 09:48:02','2025-03-21 09:48:02'),(26,32,27,4320.98,'Approved','2025-07-26 02:31:19','2025-10-26 02:31:19'),(27,21,29,13257.1,'Approved','2025-04-06 15:45:13','2025-06-27 15:45:13'),(28,34,17,14596.9,'Rejected','2024-11-04 11:02:32','2024-12-29 11:02:32'),(29,31,13,13056.3,'Pending','2025-01-17 07:04:54','2025-04-23 07:04:54'),(30,10,3,16815.1,'Rejected','2025-04-02 19:37:54','2025-06-12 19:37:54'),(31,32,26,17342.5,'Rejected','2024-11-03 06:40:04','2024-11-25 06:40:04'),(32,28,40,17192.2,'Approved','2025-02-28 20:15:12','2025-03-20 20:15:12'),(33,33,17,7090.37,'Approved','2025-05-07 03:24:57','2025-06-24 03:24:57'),(34,16,17,17133.7,'Paid','2024-12-28 22:43:19','2025-02-07 22:43:19'),(35,32,28,12990.7,'Rejected','2025-02-27 23:54:18','2025-05-06 23:54:18'),(36,28,39,11540.7,'Rejected','2025-02-24 10:59:23','2025-03-28 10:59:23'),(37,6,7,10652.1,'Approved','2025-02-01 10:01:46','2025-04-28 10:01:46'),(38,12,40,12828,'Approved','2025-05-29 20:58:09','2025-08-10 20:58:09'),(39,36,22,3391.25,'Paid','2024-11-29 21:33:21','2025-02-27 21:33:21'),(40,18,13,14825.2,'Rejected','2025-03-15 11:51:33','2025-05-31 11:51:33');
/*!40000 ALTER TABLE `insuranceclaims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `shipment_id` int DEFAULT NULL,
  `amount` float NOT NULL,
  `method` text,
  `paid_at` datetime DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `shipment_id` (`shipment_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`shipment_id`),
  CONSTRAINT `payments_chk_1` CHECK ((`method` in (_cp850'Credit Card',_cp850'Bank Transfer',_cp850'Cash',_cp850'UPI')))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,12,7936.07,'Cash','2025-08-20 14:32:42'),(2,34,6417.56,'Bank Transfer','2025-08-20 14:31:20'),(3,7,1794.3,'UPI','2025-08-20 14:31:10'),(4,28,2165.4,'UPI','2025-08-20 14:33:24'),(5,27,8536.99,'Cash','2025-08-20 14:34:59'),(6,6,6770,'Cash','2025-08-20 14:34:58'),(7,36,3987.99,'Credit Card','2025-08-20 14:33:59'),(8,27,4003.55,'Cash','2025-08-20 14:29:40'),(9,28,3011.42,'UPI','2025-08-20 14:31:32'),(10,8,5590.06,'Cash','2025-08-20 14:35:01'),(11,31,1312.06,'Cash','2025-08-20 14:31:39'),(12,14,8346.4,'Bank Transfer','2025-08-20 14:34:56'),(13,35,9247.48,'UPI','2025-08-20 14:34:40'),(14,18,1870.65,'Credit Card','2025-08-20 14:32:25'),(15,16,8840.01,'UPI','2025-08-20 14:32:59'),(16,31,4489.73,'Bank Transfer','2025-08-20 14:33:30'),(17,8,8147.74,'Credit Card','2025-08-20 14:32:04'),(18,33,4882.78,'UPI','2025-08-20 14:33:00'),(19,1,6140.53,'Credit Card','2025-08-20 14:32:30'),(20,3,4643.43,'Credit Card','2025-08-20 14:35:05'),(21,15,5138.93,'Credit Card','2025-08-20 14:28:48'),(22,22,1646.41,'Credit Card','2025-08-20 14:30:21'),(23,2,5582.4,'Bank Transfer','2025-08-20 14:30:28'),(24,25,6128.83,'Bank Transfer','2025-08-20 14:26:53'),(25,23,4601.47,'Credit Card','2025-08-20 14:29:41'),(26,13,2096.01,'UPI','2025-08-20 14:31:28'),(27,34,9065.14,'Cash','2025-08-20 14:28:21'),(28,19,7522.87,'Cash','2025-08-20 14:31:40'),(29,38,2142.81,'Cash','2025-08-20 14:27:09'),(30,17,1117.19,'UPI','2025-08-20 14:27:34'),(31,24,6033.95,'Credit Card','2025-08-20 14:27:12'),(32,37,5415.07,'Credit Card','2025-08-20 14:28:46'),(33,36,1089.55,'Credit Card','2025-08-20 14:29:38'),(34,27,2079.36,'Bank Transfer','2025-08-20 14:27:15'),(35,39,3779.84,'Credit Card','2025-08-20 14:30:14'),(36,21,5821.02,'Bank Transfer','2025-08-20 14:30:16'),(37,6,2084.31,'UPI','2025-08-20 14:30:29'),(38,34,5014.66,'Cash','2025-08-20 14:32:16'),(39,22,8209.07,'Bank Transfer','2025-08-20 14:32:06'),(40,39,3026.83,'Credit Card','2025-08-20 14:27:09');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routes`
--

DROP TABLE IF EXISTS `routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `routes` (
  `route_id` int NOT NULL AUTO_INCREMENT,
  `origin` text NOT NULL,
  `destination` text NOT NULL,
  `distance_km` float DEFAULT NULL,
  `estimated_time_hr` float DEFAULT NULL,
  `cost_estimate` float DEFAULT NULL,
  PRIMARY KEY (`route_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routes`
--

LOCK TABLES `routes` WRITE;
/*!40000 ALTER TABLE `routes` DISABLE KEYS */;
INSERT INTO `routes` VALUES (1,'Lake Andrew','Danielchester',8613.48,38.71,1355.03),(2,'Leemouth','Fowlerville',7127.53,181.85,5163.78),(3,'Annbury','Potterborough',9812.78,145.32,6283.33),(4,'Richardburgh','Matthewmouth',8362.05,197.21,2231.87),(5,'North Krystal','Maryton',661.12,56.57,6884.25),(6,'East Marcusside','North Michaelmouth',806.4,198.36,8831.17),(7,'Ortizmouth','Jeanneland',5782.19,179.81,9342.88),(8,'Rossmouth','Edwardview',460.45,99.72,7388.48),(9,'East Claudiaville','Romerobury',4117.07,79.69,4994.93),(10,'Brownchester','Port Christopherfort',1455.59,16.17,7065.58),(11,'Fernandezhaven','Gregoryhaven',8372.7,45.65,2471.25),(12,'South Jeffreyfort','East Nicole',6290.17,83.73,5315.88),(13,'East Donald','Lake Luisfurt',5070.83,182.13,709.44),(14,'East Teresa','Donnaside',7002.05,62.25,4274.65),(15,'Lake Joshuashire','Saraland',1571.46,104.26,9575.33),(16,'Ericburgh','Foxland',4235.95,45.61,9807.01),(17,'Dianeville','Morganshire',1627.31,109.08,4741.26),(18,'Port Russell','Port Wendy',522.37,97.89,9000.52),(19,'Port Joshua','Reesehaven',1939.21,65.62,344.64),(20,'New Erica','Griffinmouth',4601.72,113.37,8705.14),(21,'Lambville','Lake Ericport',1654.29,157.11,385.04),(22,'West Jessica','Jenniferberg',6702.96,60.75,406.19),(23,'Jeffreyfurt','Anthonyshire',2272.02,107.04,646.54),(24,'Lake Cameron','Deborahfort',9474.96,31.39,4347.7),(25,'New Stephanie','Danielberg',8495.35,148.19,6644.34),(26,'East Donna','Barnesport',9525.99,55.01,9712.62),(27,'North Jonathanview','New Antonio',8889.06,111.73,6465.17),(28,'New Gina','Robinborough',1698.39,36.64,8101.57),(29,'Rodriguezbury','Thomasburgh',8867.52,126.65,5883.52),(30,'Erikatown','Logantown',6993.19,63.42,783.66),(31,'West Josebury','Sullivanshire',6330.2,124.24,5131.61),(32,'Stevenview','Katherineburgh',9820.68,16.96,7623.18),(33,'Port Taylormouth','South Brianburgh',7654.68,157.47,9380.17),(34,'West Holly','Butlerton',3433.52,13.19,3422.23),(35,'North Angela','West Stephanie',9495.04,155.81,9172.93),(36,'Butlerborough','Ericaview',4476.26,7.94,5365.14),(37,'West Matthew','Wangville',1212.54,154.28,5866.45),(38,'Kylefurt','East Michaelfurt',9200.54,172.02,982.89),(39,'East Crystal','East Martin',7795.13,155.19,242.88),(40,'East Marytown','Mcknightview',7069.32,19.76,7466.26);
/*!40000 ALTER TABLE `routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipments` (
  `shipment_id` int NOT NULL AUTO_INCREMENT,
  `cargo_id` int DEFAULT NULL,
  `origin_port` text NOT NULL,
  `destination` text NOT NULL,
  `departure_time` datetime DEFAULT NULL,
  `arrival_time` datetime DEFAULT NULL,
  `mode` text,
  `vehicle_id` int DEFAULT NULL,
  `status` text,
  PRIMARY KEY (`shipment_id`),
  KEY `cargo_id` (`cargo_id`),
  KEY `vehicle_id` (`vehicle_id`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`cargo_id`),
  CONSTRAINT `shipments_ibfk_2` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`vehicle_id`),
  CONSTRAINT `shipments_chk_1` CHECK ((`mode` in (_utf8mb4'Road',_utf8mb4'Sea',_utf8mb4'Air'))),
  CONSTRAINT `shipments_chk_2` CHECK ((`status` in (_utf8mb4'Pending',_utf8mb4'In Transit',_utf8mb4'Delivered',_utf8mb4'Delayed')))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
INSERT INTO `shipments` VALUES (1,1,'Smithville','Martinezside','2024-12-05 13:09:49','2024-12-13 05:09:49','Air',19,'Pending'),(2,28,'Wallaceland','Susanburgh','2024-08-26 01:39:17','2024-08-28 06:39:17','Air',14,'In Transit'),(3,15,'North Christopherstad','New Katherineborough','2024-10-13 19:35:24','2024-10-21 17:35:24','Air',39,'Pending'),(4,18,'Douglasmouth','Williamsstad','2025-06-09 21:18:13','2025-06-17 12:18:13','Air',38,'Delayed'),(5,25,'Jensenchester','West Pamela','2025-04-12 21:52:42','2025-04-18 06:52:42','Sea',19,'Delayed'),(6,40,'North Jacquelineburgh','Adamfurt','2025-06-24 17:57:11','2025-06-25 02:57:11','Air',33,'Pending'),(7,10,'West Matthew','Devinburgh','2024-09-15 12:17:02','2024-09-17 19:17:02','Road',24,'Delivered'),(8,13,'Carlside','Contrerashaven','2025-01-06 16:06:18','2025-01-13 16:06:18','Sea',19,'Pending'),(9,17,'Johnstonshire','Tiffanymouth','2025-06-03 23:31:05','2025-06-04 20:31:05','Road',14,'In Transit'),(10,4,'South Andre','East Donald','2024-12-09 15:30:09','2024-12-11 01:30:09','Air',19,'In Transit'),(11,14,'Pattersonburgh','Lake Catherineshire','2025-03-30 23:48:59','2025-04-03 17:48:59','Road',38,'Pending'),(12,29,'Meadowsshire','East Carolyn','2025-07-10 02:03:26','2025-07-16 03:03:26','Sea',9,'Delivered'),(13,36,'South Madison','Port Reneetown','2025-08-07 22:32:10','2025-08-13 04:32:10','Sea',14,'Pending'),(14,34,'Leestad','Sharonshire','2024-11-03 03:56:20','2024-11-07 15:56:20','Air',12,'In Transit'),(15,7,'South Bruce','Jacquelineborough','2024-12-10 23:57:18','2024-12-14 23:57:18','Sea',15,'Delivered'),(16,30,'West Erikatown','Port Marioton','2025-04-30 00:06:04','2025-05-03 12:06:04','Sea',14,'Delayed'),(17,29,'Delgadoport','Richardview','2024-09-27 12:20:45','2024-09-28 07:20:45','Sea',13,'Delayed'),(18,21,'New Matthew','Port Veronicabury','2025-07-18 19:49:01','2025-07-21 21:49:01','Sea',17,'Delayed'),(19,30,'North Steventon','Mitchellchester','2025-07-03 08:22:36','2025-07-06 18:22:36','Road',10,'Pending'),(20,7,'Port Theresaport','New Maryshire','2025-06-17 13:22:40','2025-06-23 07:22:40','Sea',24,'Pending'),(21,36,'Clarkland','North Richardmouth','2025-02-20 23:50:11','2025-02-26 02:50:11','Road',20,'Delayed'),(22,4,'East Kimberlyberg','West Megan','2025-02-07 00:03:25','2025-02-10 01:03:25','Road',39,'Delayed'),(23,24,'Arellanofort','Mezaland','2025-07-04 02:56:12','2025-07-05 03:56:12','Air',23,'In Transit'),(24,9,'Frankmouth','Summerchester','2025-02-26 20:49:00','2025-03-04 23:49:00','Air',32,'Delayed'),(25,10,'New Steven','Lake Wandafurt','2024-10-29 18:07:40','2024-11-02 11:07:40','Road',10,'Delayed'),(26,28,'Jaredville','East Audrey','2025-01-09 09:54:10','2025-01-17 01:54:10','Road',4,'Delivered'),(27,7,'South Marc','Brendachester','2025-07-07 21:52:04','2025-07-11 00:52:04','Air',21,'In Transit'),(28,32,'Port Sarahview','Port Patrick','2025-04-22 20:17:20','2025-04-25 17:17:20','Air',33,'Delivered'),(29,9,'Coryview','Marcusland','2024-11-16 08:35:55','2024-11-17 03:35:55','Road',10,'Delayed'),(30,17,'Samanthaport','Millerberg','2025-02-27 11:51:24','2025-02-27 12:51:24','Sea',40,'Pending'),(31,29,'South Elijah','New Janice','2025-02-08 19:54:20','2025-02-10 04:54:20','Air',20,'Pending'),(32,25,'New Angela','Port Adam','2025-07-25 10:29:29','2025-07-31 15:29:29','Air',17,'Delivered'),(33,32,'New Jonathan','West Erica','2025-08-13 04:19:10','2025-08-21 10:19:10','Road',36,'Pending'),(34,23,'Port John','Curtisview','2024-10-01 07:27:05','2024-10-05 14:27:05','Road',14,'Delivered'),(35,16,'Taylorstad','New Darren','2025-04-07 01:05:49','2025-04-10 14:05:49','Sea',26,'Delivered'),(36,2,'Tuckertown','New Rebecca','2025-05-27 13:53:58','2025-05-30 04:53:58','Road',10,'Delivered'),(37,17,'North Kennethmouth','North Mariatown','2025-05-29 00:30:30','2025-06-01 08:30:30','Sea',1,'Pending'),(38,30,'North Tara','Valentineborough','2025-07-04 16:56:41','2025-07-07 23:56:41','Sea',2,'Delivered'),(39,12,'Tracyberg','Port Teresastad','2025-01-19 10:17:49','2025-01-26 19:17:49','Sea',11,'Pending'),(40,5,'South James','West Christinatown','2025-08-14 09:42:46','2025-08-17 03:42:46','Road',20,'Delivered');
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trackinglogs`
--

DROP TABLE IF EXISTS `trackinglogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trackinglogs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `shipment_id` int DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `location` text,
  `status` text,
  `remarks` text,
  PRIMARY KEY (`log_id`),
  KEY `shipment_id` (`shipment_id`),
  CONSTRAINT `trackinglogs_ibfk_1` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`shipment_id`),
  CONSTRAINT `trackinglogs_chk_1` CHECK ((`status` in (_utf8mb4'In transit',_utf8mb4'Delayed',_utf8mb4'Checked-in')))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trackinglogs`
--

LOCK TABLES `trackinglogs` WRITE;
/*!40000 ALTER TABLE `trackinglogs` DISABLE KEYS */;
INSERT INTO `trackinglogs` VALUES (1,36,'2024-08-30 14:15:54','Port Ashley','Checked-in','Design nothing ground defense.'),(2,33,'2025-05-30 03:43:40','Lake Valeriestad','Checked-in','Reveal international attack tax.'),(3,28,'2024-09-15 15:58:48','East Sheila','In transit','Hotel star strong crime land end.'),(4,18,'2024-09-01 07:44:11','North Samanthaborough','Delayed','At short democratic majority.'),(5,25,'2025-02-18 04:24:58','North Stevenchester','Checked-in','Born chance thank which.'),(6,34,'2025-05-25 12:39:22','Port Anna','In transit','Money specific system friend.'),(7,16,'2024-12-18 08:42:38','Higginstown','Delayed','Way population year traditional college.'),(8,31,'2025-04-21 13:22:39','Danielfurt','In transit','Me financial at rock.'),(9,5,'2025-05-09 05:13:23','Davisside','Delayed','Policy trade care question our ask history.'),(10,9,'2024-10-25 05:35:05','Wayneburgh','In transit','Never conference situation recognize head.'),(11,9,'2025-05-18 21:44:44','West Jenniferberg','Checked-in','Environmental seem plan.'),(12,21,'2025-08-01 17:01:32','South Timothymouth','Checked-in','During example still yard stop half affect just.'),(13,3,'2024-11-18 03:52:44','Port Jasonburgh','In transit','Order soon Democrat purpose politics.'),(14,40,'2025-07-23 23:46:16','Lake Julieberg','Delayed','Pretty bad often pay thing.'),(15,32,'2025-07-22 12:14:42','Morrisonfurt','Delayed','News movement body enough.'),(16,38,'2025-07-11 09:30:41','West April','Checked-in','Firm participant news.'),(17,33,'2025-06-30 08:40:29','Jamieport','Delayed','Data strategy art still suffer use.'),(18,25,'2024-10-26 09:05:06','Waltersport','In transit','Police minute test data hour key thus.'),(19,37,'2024-09-10 01:24:46','Stoneville','In transit','Onto field research conference.'),(20,13,'2024-10-28 09:37:17','South Danielle','In transit','Half model different goal.'),(21,31,'2025-07-27 07:16:33','Gonzalezhaven','In transit','Mission raise former certain trip.'),(22,18,'2025-05-29 18:38:34','South Amberburgh','Checked-in','Culture music each event wonder car.'),(23,31,'2024-09-10 09:16:57','Robinsonport','In transit','Face again brother keep.'),(24,16,'2025-08-07 13:52:56','Patrickbury','Checked-in','Probably know important choose.'),(25,30,'2025-08-19 16:25:25','West Jasonstad','Checked-in','Few garden civil garden enough.'),(26,10,'2024-11-22 01:20:07','Port Garyburgh','Delayed','Win box last avoid central director doctor.'),(27,22,'2025-08-04 12:55:35','Meganchester','Checked-in','Statement gun statement receive.'),(28,18,'2025-01-07 22:01:19','North Bryanshire','Delayed','Half myself gas fund claim.'),(29,30,'2024-09-03 03:18:08','Williamsburgh','Checked-in','Kid view right reveal economy.'),(30,28,'2025-04-06 14:40:16','Alvareztown','Checked-in','Health whole executive throw hospital.'),(31,18,'2024-09-19 06:48:35','Moorefurt','In transit','Fish hold easy outside music trip.'),(32,23,'2025-01-31 09:48:05','West Miranda','Checked-in','Well citizen worry very begin.'),(33,29,'2025-05-17 09:00:02','Castromouth','In transit','Own add represent vote reflect.'),(34,4,'2024-10-31 12:30:57','Hannahaven','Delayed','Sing fine brother according wait threat white.'),(35,17,'2025-06-13 12:56:32','South Amber','Checked-in','Price chair point successful.'),(36,35,'2025-06-14 07:48:23','West Joanne','Checked-in','Arrive protect chance hundred ball region eye enough.'),(37,24,'2025-07-06 18:40:38','Jacquelinemouth','Checked-in','Occur bank health strong late.'),(38,33,'2025-02-17 19:03:00','Contrerasborough','Checked-in','Generation unit response do PM shoulder.'),(39,36,'2025-08-08 03:57:54','New Steven','Delayed','Executive discuss account entire huge.'),(40,10,'2024-12-05 21:05:38','New Johnathan','In transit','Plant organization modern analysis law real become.');
/*!40000 ALTER TABLE `trackinglogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `vehicle_id` int NOT NULL AUTO_INCREMENT,
  `type` text,
  `capacity_kg` float NOT NULL,
  `capacity_m3` float NOT NULL,
  `driver_name` text,
  `fuel_cost_per_km` float DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`),
  CONSTRAINT `vehicles_chk_1` CHECK ((`type` in (_utf8mb4'Truck',_utf8mb4'Ship',_utf8mb4'Plane')))
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES (1,'Ship',41694.6,104.87,'Edward Berry',3.13),(2,'Ship',47524.1,380.33,'Yvette Tyler',5.19),(3,'Truck',16188.8,31.49,'Laura Fry',4.5),(4,'Ship',23410.8,425.19,'Penny Murray',6.27),(5,'Truck',13895.2,503.81,'Sarah Graham',7.21),(6,'Truck',10625.5,490.76,'Jeremy Wallace',1.06),(7,'Ship',11365.5,124.25,'Kyle Wilkinson',7.5),(8,'Ship',42081.9,825.86,'Catherine Rice',8.25),(9,'Truck',6464.83,924.87,'Alexa Rubio',9.62),(10,'Plane',27113.8,86.66,'Michael Shaw',5.61),(11,'Ship',16148.9,109.21,'Crystal Harris',6.83),(12,'Truck',16334,486.39,'Ryan Mcguire',2.02),(13,'Truck',4712.74,70.05,'Chad Le',1.54),(14,'Ship',35554.9,666.38,'Brenda Neal',5.06),(15,'Ship',33683.7,392.61,'Jason Garrison',1.77),(16,'Ship',24006.4,265.58,'Kevin Johnson',3.8),(17,'Plane',37154.3,41.72,'Joseph Morgan',2.56),(18,'Truck',27448.8,223.64,'Jennifer Robbins',9.7),(19,'Plane',24898,601.16,'Douglas Nelson',4.08),(20,'Truck',1570.86,96.6,'Cristian Peters',8.9),(21,'Truck',25284.1,963.11,'Michael Davis',4.01),(22,'Truck',21946.1,667.1,'Joshua Gonzalez',4.13),(23,'Ship',46991.2,400.01,'Katherine Perry',7.25),(24,'Ship',11530.6,159.86,'Nancy Melton',6.18),(25,'Plane',30269.5,46.41,'Daniel Hill',8.6),(26,'Ship',28829.8,107.79,'Nancy Miles',8.3),(27,'Ship',21107.9,454.74,'Victoria Silva',2.74),(28,'Plane',45325.1,865.47,'Christopher Walker',2.14),(29,'Plane',32653.3,990.61,'Angela Navarro',8.88),(30,'Ship',16615.7,174.22,'Matthew Frank',8.1),(31,'Plane',41707.2,975.78,'Richard Thomas',1.39),(32,'Plane',23486.8,381.9,'Mark Bauer',9.14),(33,'Ship',36183.2,833.46,'Danielle Velez',5.58),(34,'Ship',1700.11,288.99,'Isaiah Alexander',2.02),(35,'Truck',33675.8,446.98,'Regina Frost',8.4),(36,'Plane',39372.2,282.08,'Christopher Barry',2.14),(37,'Ship',20069.9,100.73,'Joseph Snow',4.37),(38,'Ship',30049.7,245.1,'Jennifer Gonzalez',5.24),(39,'Ship',2894.62,847.07,'Sherry Spencer',9.76),(40,'Plane',20436.7,630.18,'Laura Burke',6.42);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouses` (
  `warehouse_id` int NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `location` text NOT NULL,
  `capacity_kg` float NOT NULL,
  `capacity_m3` float NOT NULL,
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` VALUES (1,'Jones-Castillo Warehouse','Lake Jonathanview',383454,19313),(2,'Black-Craig Warehouse','Moodyburgh',28169.9,14419.4),(3,'Rivera-James Warehouse','Lake Jackiefurt',460218,13411.1),(4,'Watkins, Daniels and Moore Warehouse','West April',219161,6048.28),(5,'Gonzalez, Baker and Roy Warehouse','South Andrea',332495,9794.2),(6,'Rodriguez LLC Warehouse','Lauriemouth',51283.7,6338.74),(7,'Berg-Thompson Warehouse','Fieldsmouth',98697,17744.4),(8,'Vaughn, Patterson and Garrett Warehouse','North Jessica',236543,4721.18),(9,'Yoder, Adams and Hughes Warehouse','South Leslieview',13505.8,10279.1),(10,'Flores, Kelley and Hatfield Warehouse','East Davidchester',268943,12662.9),(11,'Rodriguez-Garza Warehouse','Nancyshire',333657,12206.2),(12,'Mclaughlin, Flores and Melton Warehouse','Jonesmouth',56685.2,8964.64),(13,'Schmidt, Hill and Little Warehouse','Valdezfurt',339799,4634.24),(14,'Wong PLC Warehouse','East Johntown',270985,10697.4),(15,'Fox-Oconnor Warehouse','Charlesland',185306,18277.2),(16,'Jones-Wallace Warehouse','Barberchester',99904.3,3435.41),(17,'Bowen and Sons Warehouse','Davidton',180151,14611.3),(18,'Black-Shaw Warehouse','Luisfurt',215213,17660),(19,'Moore-Davis Warehouse','North Moniqueberg',453134,1217.05),(20,'Barnes LLC Warehouse','Williamsmouth',395099,2411.26),(21,'Hoffman PLC Warehouse','Lake Jamieberg',404502,13507.8),(22,'Monroe and Sons Warehouse','South Christopher',143685,5436.83),(23,'Ramos-Gilmore Warehouse','Jamesbury',46960.1,4077.8),(24,'Gilbert, Ryan and White Warehouse','Reynoldsport',101174,10469.2),(25,'Lee-Zimmerman Warehouse','West Johnberg',290843,19620.7),(26,'Clark PLC Warehouse','South Randall',210136,1900.34),(27,'Cabrera-Ray Warehouse','Caitlynhaven',415694,13221.7),(28,'Stone, Hoover and Rodriguez Warehouse','Victorside',247508,7699.75),(29,'Garcia, Mcdaniel and Summers Warehouse','Lake Kristenview',400644,12646.6),(30,'Swanson and Sons Warehouse','Lake Anthony',271552,16179.2),(31,'Smith, Downs and Hicks Warehouse','North Jennifer',421679,19545.3),(32,'Schmidt-Wilson Warehouse','South Mauriceview',467137,3627.73),(33,'Hess-Smith Warehouse','Brownberg',380377,14156.2),(34,'Mcdaniel-Reynolds Warehouse','Parkschester',82638.5,12703.5),(35,'Glenn, Bates and Martin Warehouse','Port Joy',50657.5,9059.99),(36,'Maynard Inc Warehouse','South Lisa',224564,6387.44),(37,'Perez PLC Warehouse','East Benjaminbury',149091,5807.65),(38,'Richardson-Walker Warehouse','Lake Charles',396870,10725.2),(39,'Newman-Juarez Warehouse','Robertland',66623.6,2521.14),(40,'Vazquez Inc Warehouse','Robinsonburgh',278529,17460.6);
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehousestorage`
--

DROP TABLE IF EXISTS `warehousestorage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehousestorage` (
  `storage_id` int NOT NULL AUTO_INCREMENT,
  `cargo_id` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `stored_at` datetime NOT NULL,
  `released_at` datetime DEFAULT NULL,
  PRIMARY KEY (`storage_id`),
  KEY `cargo_id` (`cargo_id`),
  KEY `warehouse_id` (`warehouse_id`),
  CONSTRAINT `warehousestorage_ibfk_1` FOREIGN KEY (`cargo_id`) REFERENCES `cargo` (`cargo_id`),
  CONSTRAINT `warehousestorage_ibfk_2` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`warehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehousestorage`
--

LOCK TABLES `warehousestorage` WRITE;
/*!40000 ALTER TABLE `warehousestorage` DISABLE KEYS */;
INSERT INTO `warehousestorage` VALUES (1,21,22,'2025-02-03 19:43:45','2025-02-24 19:43:45'),(2,35,33,'2025-03-03 10:36:23','2025-05-05 10:36:23'),(3,17,16,'2025-01-30 15:22:58','2025-02-04 15:22:58'),(4,29,13,'2025-01-09 06:45:55','2025-03-11 06:45:55'),(5,5,28,'2025-05-05 15:45:24','2025-05-25 15:45:24'),(6,22,19,'2025-08-05 03:19:33','2025-10-13 03:19:33'),(7,19,12,'2024-10-15 18:21:08','2024-10-31 18:21:08'),(8,9,7,'2024-09-05 20:12:30','2024-11-29 20:12:30'),(9,25,11,'2025-01-17 18:13:54','2025-02-03 18:13:54'),(10,30,4,'2024-09-08 16:00:30','2024-09-25 16:00:30'),(11,5,25,'2025-01-21 12:44:20','2025-04-04 12:44:20'),(12,34,2,'2025-01-20 06:20:24','2025-02-21 06:20:24'),(13,6,6,'2024-11-06 13:17:56','2025-01-21 13:17:56'),(14,40,31,'2024-10-23 03:20:03','2024-12-21 03:20:03'),(15,5,4,'2025-03-11 23:31:26','2025-03-19 23:31:26'),(16,4,19,'2024-11-27 01:16:44','2025-02-20 01:16:44'),(17,4,2,'2024-08-22 04:08:02','2024-09-24 04:08:02'),(18,11,18,'2025-03-08 01:06:19','2025-03-26 01:06:19'),(19,12,17,'2025-01-14 16:20:13','2025-03-03 16:20:13'),(20,10,2,'2025-05-12 21:24:54','2025-08-01 21:24:54'),(21,29,2,'2025-03-13 11:46:49','2025-05-18 11:46:49'),(22,18,9,'2025-04-19 11:29:16','2025-04-29 11:29:16'),(23,36,2,'2025-03-17 04:04:57','2025-04-16 04:04:57'),(24,32,10,'2025-07-06 20:08:38','2025-08-30 20:08:38'),(25,3,18,'2025-02-01 13:07:00','2025-02-18 13:07:00'),(26,14,9,'2025-04-29 03:07:22','2025-06-19 03:07:22'),(27,37,7,'2025-04-24 15:07:14','2025-05-14 15:07:14'),(28,34,17,'2025-04-27 10:26:16','2025-07-12 10:26:16'),(29,7,15,'2025-07-15 01:26:42','2025-08-11 01:26:42'),(30,29,6,'2024-12-18 17:11:51','2025-02-13 17:11:51'),(31,39,4,'2024-10-19 04:14:12','2024-11-02 04:14:12'),(32,35,16,'2024-09-04 07:36:44','2024-09-26 07:36:44'),(33,6,10,'2025-02-11 19:33:16','2025-02-21 19:33:16'),(34,3,10,'2024-09-04 02:36:05','2024-11-06 02:36:05'),(35,9,13,'2025-01-07 13:47:19','2025-02-04 13:47:19'),(36,12,10,'2025-02-01 21:00:50','2025-04-10 21:00:50'),(37,11,8,'2024-09-13 06:19:51','2024-10-05 06:19:51'),(38,29,16,'2025-07-06 13:15:26','2025-09-15 13:15:26'),(39,34,9,'2025-01-13 08:34:14','2025-03-31 08:34:14'),(40,7,7,'2025-02-24 00:40:30','2025-04-29 00:40:30');
/*!40000 ALTER TABLE `warehousestorage` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-30  0:28:58
