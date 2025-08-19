CREATE DATABASE  IF NOT EXISTS `coderhouse` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `coderhouse`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: coderhouse
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `alumnos`
--

DROP TABLE IF EXISTS `alumnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alumnos` (
  `id_alumno` int DEFAULT NULL,
  `nombre` text,
  `apellido` text,
  `email` text,
  `dni` int DEFAULT NULL,
  `edad` int DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  `nacionalidad` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumnos`
--

LOCK TABLES `alumnos` WRITE;
/*!40000 ALTER TABLE `alumnos` DISABLE KEYS */;
INSERT INTO `alumnos` VALUES (1,'Diego','Fernandez','diego@mail.com',23565656,18,1133366,'Argentina'),(2,'Sabrina','Gonzalez','sabri@gmail.com',33556565,18,11555666,'Argentina'),(3,'Soledad','Pastoruti','lasole@mail.com',40565655,35,1156666,'Brasil'),(4,'Enrique','Octavo','henry@mail.com',6521212,18,2265656,'Argentina'),(5,'Fabrizzio','Primero','fabri@mail.com',2564862,18,2299656,'Argentina'),(10,'Micaela','Fernandez','mica@gmail.com',33365656,25,12345678,'Uruguay'),(11,'Sabrina Lorena','Gonzalez','sabrilo@mail.com',33599965,29,11551166,'Brasil'),(12,'Soledad','Hecheverrria','sole@gmail.com',4999655,35,11534666,'Uruguay'),(13,'Enrique','Pintos','enrique@mail.com',16521212,22,12265656,'Chile'),(18,'Analia','Ramirez',NULL,27565656,NULL,NULL,'Argentina');
/*!40000 ALTER TABLE `alumnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id_categoria` int DEFAULT NULL,
  `nombre_categoria` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Base de Datos'),(2,'Programacion'),(3,'Cloud'),(4,'UX/UI');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cursos` (
  `id_curso` int DEFAULT NULL,
  `nombre_curso` text,
  `id_categoria` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` VALUES (1,'SQL Basico',1),(2,'SQL Avanzado',1),(3,'JavaScript',2),(4,'Backend',2),(5,'Java',2),(6,'Python',2),(7,'Docker',3),(8,'AWS',3),(9,'Figma',4),(10,'Canva',4),(11,'Google Cloud',3),(12,'Azure',3);
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscripciones`
--

DROP TABLE IF EXISTS `inscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscripciones` (
  `idx_alumno` int DEFAULT NULL,
  `idx_curso` int DEFAULT NULL,
  `inscription_at` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscripciones`
--

LOCK TABLES `inscripciones` WRITE;
/*!40000 ALTER TABLE `inscripciones` DISABLE KEYS */;
INSERT INTO `inscripciones` VALUES (1,1,'2025-07-29 20:37:56'),(1,2,'2025-07-29 20:37:56'),(1,6,'2025-07-29 20:37:56'),(1,8,'2025-08-12 19:37:31'),(1,9,'2025-08-12 19:37:31'),(1,11,'2025-08-12 20:10:19'),(1,12,'2025-08-12 20:52:43'),(2,4,'2025-07-29 20:37:56'),(2,6,'2025-07-29 20:37:56'),(2,11,'2025-08-12 20:10:19'),(2,12,'2025-08-12 20:52:43'),(3,3,'2025-07-29 20:37:56'),(3,8,'2025-08-12 19:37:31'),(3,9,'2025-08-12 19:37:31'),(3,11,'2025-08-12 20:10:19'),(3,12,'2025-08-12 20:52:43'),(4,1,'2025-07-29 20:37:56'),(4,2,'2025-07-29 20:37:56'),(4,3,'2025-07-29 20:37:56'),(4,11,'2025-08-12 20:10:19'),(4,12,'2025-08-12 20:52:43'),(5,8,'2025-08-12 19:37:31'),(5,9,'2025-08-12 19:37:31'),(5,11,'2025-08-12 20:10:19'),(5,12,'2025-08-12 20:52:43'),(10,8,'2025-08-12 19:37:31'),(10,9,'2025-08-12 19:37:31'),(10,11,'2025-08-12 20:10:19'),(10,12,'2025-08-12 20:52:43'),(11,11,'2025-08-12 20:10:19'),(11,12,'2025-08-12 20:52:43'),(12,8,'2025-08-12 19:37:31'),(12,9,'2025-08-12 19:37:31'),(12,11,'2025-08-12 20:10:19'),(12,12,'2025-08-12 20:52:43'),(13,11,'2025-08-12 20:10:19'),(13,12,'2025-08-12 20:52:43');
/*!40000 ALTER TABLE `inscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'coderhouse'
--

--
-- Dumping routines for database 'coderhouse'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-19 20:13:16
