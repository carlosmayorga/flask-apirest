-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Nov 13, 2018 at 04:07 AM
-- Server version: 5.7.23
-- PHP Version: 7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `madrid`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_md_create_player` (IN `i_name` VARCHAR(100), IN `i_tshirt` INT, IN `i_position` VARCHAR(100))  BEGIN
INSERT 
   INTO md_player( 
        name,
        tshirt,
        position
   )
   VALUES(
        i_name,
        i_tshirt,
        i_position);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_md_find_player` (IN `i_position` VARCHAR(100))  BEGIN
  SELECT idNative, 
         name, 
         tshirt, 
         position 
  FROM md_player 
  WHERE position = i_position;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `md_player`
--

CREATE TABLE `md_player` (
  `idNative` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `tshirt` int(11) NOT NULL,
  `position` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `md_player`
--

INSERT INTO `md_player` (`idNative`, `name`, `tshirt`, `position`) VALUES
(1, 'sergio ramos', 4, 'defensa'),
(2, 'carvajal', 3, 'lateral'),
(3, 'varane', 2, 'defensa'),
(4, 'asensio', 20, 'delantero');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `md_player`
--
ALTER TABLE `md_player`
  ADD PRIMARY KEY (`idNative`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `md_player`
--
ALTER TABLE `md_player`
  MODIFY `idNative` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
