CREATE DATABASE  IF NOT EXISTS `movie` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `movie`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: movie
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Temporary view structure for view `genremoviecount`
--

DROP TABLE IF EXISTS `genremoviecount`;
/*!50001 DROP VIEW IF EXISTS `genremoviecount`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `genremoviecount` AS SELECT 
 1 AS `genre`,
 1 AS `NumberMovies`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `genretagcount`
--

DROP TABLE IF EXISTS `genretagcount`;
/*!50001 DROP VIEW IF EXISTS `genretagcount`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `genretagcount` AS SELECT 
 1 AS `genre`,
 1 AS `NumberTags`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `averagemovierating`
--

DROP TABLE IF EXISTS `averagemovierating`;
/*!50001 DROP VIEW IF EXISTS `averagemovierating`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `averagemovierating` AS SELECT 
 1 AS `title`,
 1 AS `AverageRating`,
 1 AS `NumberRatings`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `movietagcount`
--

DROP TABLE IF EXISTS `movietagcount`;
/*!50001 DROP VIEW IF EXISTS `movietagcount`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `movietagcount` AS SELECT 
 1 AS `title`,
 1 AS `NumberTags`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `averagegenrerating`
--

DROP TABLE IF EXISTS `averagegenrerating`;
/*!50001 DROP VIEW IF EXISTS `averagegenrerating`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `averagegenrerating` AS SELECT 
 1 AS `genre`,
 1 AS `AverageRating`,
 1 AS `NumberRatings`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `averageuserrating`
--

DROP TABLE IF EXISTS `averageuserrating`;
/*!50001 DROP VIEW IF EXISTS `averageuserrating`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `averageuserrating` AS SELECT 
 1 AS `userID`,
 1 AS `AverageRating`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `genremoviecount`
--

/*!50001 DROP VIEW IF EXISTS `genremoviecount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `genremoviecount` AS select `genre`.`genre` AS `genre`,count(`moviegenre`.`movieID`) AS `NumberMovies` from (`moviegenre` left join `genre` on((`genre`.`genreID` = `moviegenre`.`genreID`))) group by `genre`.`genreID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `genretagcount`
--

/*!50001 DROP VIEW IF EXISTS `genretagcount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `genretagcount` AS select `genre`.`genre` AS `genre`,count(`tagusermovie`.`tagID`) AS `NumberTags` from (`tagusermovie` left join (`moviegenre` left join `genre` on((`genre`.`genreID` = `moviegenre`.`genreID`))) on((`tagusermovie`.`movieID` = `moviegenre`.`movieID`))) group by `genre`.`genreID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `averagemovierating`
--

/*!50001 DROP VIEW IF EXISTS `averagemovierating`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `averagemovierating` AS select `movie`.`title` AS `title`,avg(`ratings`.`rating`) AS `AverageRating`,count(`ratings`.`rating`) AS `NumberRatings` from ((`ratingusermovie` left join `movie` on((`movie`.`movieID` = `ratingusermovie`.`movieID`))) join `ratings` on((`ratings`.`ratingID` = `ratingusermovie`.`ratingID`))) group by `movie`.`movieID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `movietagcount`
--

/*!50001 DROP VIEW IF EXISTS `movietagcount`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `movietagcount` AS select `movie`.`title` AS `title`,count(`tags`.`tag`) AS `NumberTags` from ((`tagusermovie` left join `movie` on((`movie`.`movieID` = `tagusermovie`.`movieID`))) join `tags` on((`tagusermovie`.`tagID` = `tags`.`tagID`))) group by `movie`.`movieID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `averagegenrerating`
--

/*!50001 DROP VIEW IF EXISTS `averagegenrerating`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `averagegenrerating` AS select `genre`.`genre` AS `genre`,avg(`ratings`.`rating`) AS `AverageRating`,count(`genre`.`genreID`) AS `NumberRatings` from ((`ratingusermovie` left join (`moviegenre` left join `genre` on((`genre`.`genreID` = `moviegenre`.`genreID`))) on((`moviegenre`.`movieID` = `ratingusermovie`.`movieID`))) join `ratings` on((`ratingusermovie`.`ratingID` = `ratings`.`ratingID`))) group by `genre`.`genreID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `averageuserrating`
--

/*!50001 DROP VIEW IF EXISTS `averageuserrating`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `averageuserrating` AS select `username`.`userID` AS `userID`,avg(`ratings`.`rating`) AS `AverageRating` from ((`username` left join `ratingusermovie` on((`username`.`userID` = `ratingusermovie`.`userID`))) join `ratings` on((`ratingusermovie`.`ratingID` = `ratings`.`ratingID`))) group by `username`.`userID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping routines for database 'movie'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-02 17:17:09
