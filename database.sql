-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: std-mysql    Database: std_2448_exam
-- ------------------------------------------------------
-- Server version       5.7.26-0ubuntu0.16.04.1

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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('155af48e1edc');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `short_desc` text NOT NULL,
  `year` int(11) NOT NULL,
  `publisher` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `volume` int(11) NOT NULL,
  `image_id` varchar(100) NOT NULL,
  `rating_sum` int(11) NOT NULL,
  `rating_num` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_books_image_id_images` (`image_id`),
  CONSTRAINT `fk_books_image_id_images` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (42,'Книга1','<ol>\n<li>fe</li>\n<li>few</li>\n<li>few</li>\n<li>few\n<strong>vdsvdsvds</strong></li>\n</ol>\n<ol>\n<li><strong>fewfew</strong>\'</li>\n</ol>',1866,'Издатель1','Автор1',111,'303112a3-90ff-4c07-bc08-8712143a224d',0,0),(43,'Название','<ol>\n<li>fe</li>\n<li>few</li>\n<li>few</li>\n<li>few\n<strong>vdsvdsvds</strong></li>\n</ol>\n<ol>\n<li><strong>fewfew</strong>\'</li>\n</ol>',4313,'ацуауц','Пушкин',1213,'29e0e47a-a657-4cfc-971e-6216e17d0c19',0,0),(44,'Удушье','<ol>\n<li>fe</li>\n<li>few</li>\n<li>few</li>\n<li>few\n<strong>vdsvdsvds</strong></li>\n</ol>\n<ol>\n<li><strong>fewfew</strong>\'</li>\n</ol>',333,'Эксмо','Чак Паланик',431,'62693f3f-77c7-4690-b12e-7d4f11bed6fd',0,0),(45,'Название3','&lt;p&gt;уцаав&lt;/p&gt;',1,'Издатель3','Автор3',541,'9d70afca-6de6-4b62-a601-e153fba9992c',0,0),(46,'ацупк','<ol>\n<li>fe</li>\n<li>few</li>\n<li>few</li>\n<li>few\n<strong>vdsvdsvds</strong></li>\n</ol>\n<ol>\n<li><strong>fewfew</strong>\'</li>\n</ol>',562,'пцйк','ацукйп',312,'07aa6c62-3fbc-4493-bd9e-0ee141b12912',0,0),(47,'пукпку','<ol>\n<li>fe</li>\n<li>few</li>\n<li>few</li>\n<li>few\n<strong>vdsvdsvds</strong></li>\n</ol>\n<ol>\n<li><strong>fewfew</strong>\'</li>\n</ol>',124,'пук','пку',543,'342e17a3-3b3f-4687-884b-de694a684dda',10,2),(48,'очси','<ol>\n<li>fe</li>\n<li>few</li>\n<li>few</li>\n<li>few\n<strong>vdsvdsvds</strong></li>\n</ol>\n<ol>\n<li><strong>fewfew</strong>\'</li>\n</ol>',765,'куйп','мямфы',432,'97d8fbde-82d0-4863-a99e-43abc0c539bf',0,0),(49,'пупку','<ol>\r\n<li>fe</li>\r\n<li>few</li>\r\n<li>few</li>\r\n<li>few\r\n<strong>vdsvdsvds</strong></li>\r\n</ol>\r\n<ol>\r\n<li><strong>fewfew</strong>\'</li>\r\n</ol>',534543,'уацау','пку',65432,'342e17a3-3b3f-4687-884b-de694a684dda',5,1),(50,'купку','&lt;p&gt;цкакц&lt;/p&gt;',524,'пку','пку',5436,'e3df55d1-162f-4dae-b6cf-a724d4418802',0,0),(51,'ауцауц','&lt;p&gt;ауц&lt;/p&gt;',423,'ауц','ауц',432,'d34441c2-a508-484f-9f4f-8c513005bb06',0,0),(52,'545','<ol>\n<li>fe</li>\n<li>few</li>\n<li>few</li>\n<li>few\n<strong>vdsvdsvds</strong></li>\n</ol>\n<ol>\n<li><strong>fewfew</strong>\'</li>\n</ol>',545,'545','545',545,'9b644bc7-fb1b-481b-b0db-49290cbf6877',0,0);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_genres`
--

DROP TABLE IF EXISTS `books_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_books_genres_book_id_books` (`book_id`),
  KEY `fk_books_genres_genre_id_genres` (`genre_id`),
  CONSTRAINT `fk_books_genres_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `fk_books_genres_genre_id_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_genres`
--

LOCK TABLES `books_genres` WRITE;
/*!40000 ALTER TABLE `books_genres` DISABLE KEYS */;
INSERT INTO `books_genres` VALUES (218,42,1),(219,42,3),(220,42,11),(221,42,12),(222,43,11),(223,43,12),(224,44,1),(225,44,11),(226,44,13),(227,45,2),(228,45,3),(229,45,10),(230,45,11),(231,45,12),(232,46,2),(233,46,3),(234,47,11),(235,47,12),(236,47,13),(237,48,11),(238,48,13),(239,49,2),(240,49,3),(241,49,4),(242,50,1),(243,50,3),(244,51,2),(245,51,4),(246,52,1),(247,52,11),(248,52,12),(249,52,13);
/*!40000 ALTER TABLE `books_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'фэнтези'),(2,'роман-эпопея'),(3,'роман'),(4,'повесть'),(5,'рассказ'),(6,'новелла'),(7,'притча'),(8,'сказка'),(9,'ода'),(10,'элегия'),(11,'драма'),(12,'комедия'),(13,'трагедия');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` varchar(100) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `md5_hash` varchar(100) NOT NULL,
  `object_id` int(11) DEFAULT NULL,
  `object_type` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_images_md5_hash` (`md5_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES ('07aa6c62-3fbc-4493-bd9e-0ee141b12912','Ketrin_Stokett__Prisluga.jpeg','image/jpeg','3d4b5fe2467491db67ca126c1b562598',NULL,NULL,'2024-06-12 04:12:58'),('29e0e47a-a657-4cfc-971e-6216e17d0c19','Artur_Konan_Dojl__Ves_Sherlok_Holms_sbornik.jpeg','image/jpeg','5faa2741e60f5ad466c506b23666c328',NULL,NULL,'2024-06-12 04:10:18'),('303112a3-90ff-4c07-bc08-8712143a224d','Aleksandr_Dyuma__Graf_MonteKristo.jpeg','image/jpeg','af35ef000ea262f0d236305395eec0ca',NULL,NULL,'2024-06-12 04:05:46'),('342e17a3-3b3f-4687-884b-de694a684dda','Mario_Pyuzo__Krestnyj_otets.jpeg','image/jpeg','39bf0aeaad36821b9a8069225f4215f9',NULL,NULL,'2024-06-12 04:13:49'),('62693f3f-77c7-4690-b12e-7d4f11bed6fd','Deniel_Kiz__Tsvety_dlya_Eldzhernona.jpeg','image/jpeg','2c98035240c7da214ac2d3de3de0276f',NULL,NULL,'2024-06-12 04:11:21'),('97d8fbde-82d0-4863-a99e-43abc0c539bf','Margaret_Mitchell__Unesennye_vetrom.jpeg','image/jpeg','1c5684d03ba1b3f7ed9be0224404380a',NULL,NULL,'2024-06-12 04:15:49'),('9b644bc7-fb1b-481b-b0db-49290cbf6877','Stiven_King__Zeljonaya_milya.jpeg','image/jpeg','82c2445a251530ac862c768548a77f05',NULL,NULL,'2024-06-12 04:18:35'),('9d70afca-6de6-4b62-a601-e153fba9992c','Dzhon_R._R._Tolkin__Vlastelin_kolets.jpeg','image/jpeg','ea934d54281640db78b37f69952c67ca',NULL,NULL,'2024-06-12 04:12:07'),('d34441c2-a508-484f-9f4f-8c513005bb06','jpg','image/jpeg','f17c293c74a2858b360e17a22a64285e',NULL,NULL,'2024-06-12 04:17:50'),('e3df55d1-162f-4dae-b6cf-a724d4418802','Markus_Zusak__Knizhnyj_vor.jpeg','image/jpeg','756d2d5d49df8e2e90e983b6ef9da960',NULL,NULL,'2024-06-12 04:17:35');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime NOT NULL,
  `book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reviews_book_id_books` (`book_id`),
  KEY `fk_reviews_user_id_users` (`user_id`),
  CONSTRAINT `fk_reviews_book_id_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  CONSTRAINT `fk_reviews_user_id_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (47,5,'<ol>\n<li>fe</li>\n<li>few</li>\n<li>few</li>\n<li>few\n<strong>vdsvdsvds</strong></li>\n</ol>\n<ol>\n<li><strong>fewfew</strong>\'</li>\n</ol>','2024-06-12 04:32:03',47,1),(48,5,'<ol>\n<li>fe</li>\n<li>few</li>\n<li>few</li>\n<li>few\n<strong>vdsvdsvds</strong></li>\n</ol>\n<ol>\n<li><strong>fewfew</strong>\'</li>\n</ol>','2024-06-12 04:32:22',49,1);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `desc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'администратор','суперпользователь, имеет полный доступ к системе, в том числе к созданию и удалению книг'),(2,'модератор','может редактировать данные книг и производить модерацию рецензий'),(3,'пользователь','может оставлять рецензии');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_login` (`login`),
  KEY `fk_users_role_id_roles` (`role_id`),
  CONSTRAINT `fk_users_role_id_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'user','scrypt:32768:8:1$sur2Gpj0aqHnlXmc$4df031f05065618ef45c5e4988f0ff7e7a652401a70a826e7256f4062cd065733bc46ba5d97616ecf58f83b52478f047a77c4201d3a2f9b923dd6031b090d233','Иван','Иванов',NULL,1),(2,'user1','scrypt:32768:8:1$sur2Gpj0aqHnlXmc$4df031f05065618ef45c5e4988f0ff7e7a652401a70a826e7256f4062cd065733bc46ba5d97616ecf58f83b52478f047a77c4201d3a2f9b923dd6031b090d233','Илья','Аверин','Олегович',2),(3,'user2','scrypt:32768:8:1$sur2Gpj0aqHnlXmc$4df031f05065618ef45c5e4988f0ff7e7a652401a70a826e7256f4062cd065733bc46ba5d97616ecf58f83b52478f047a77c4201d3a2f9b923dd6031b090d233','Олег','ОлегОлег','Олег',3);
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

-- Dump completed on 2024-06-12  4:37:38