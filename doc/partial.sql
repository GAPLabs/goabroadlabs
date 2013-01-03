-- phpMyAdmin SQL Dump
-- version 3.5.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 03, 2013 at 01:32 AM
-- Server version: 5.5.28
-- PHP Version: 5.4.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `goabroadlabs`
--

-- --------------------------------------------------------

--
-- Table structure for table `codes`
--

CREATE TABLE IF NOT EXISTS `codes` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `codes`
--

INSERT INTO `codes` (`id`, `code`, `owner`, `description`) VALUES
(1, 'CODEUP1001', 'UP', 'Code for UP. '),
(2, 'CODELNU2002', 'LNU', 'Code for LNU');

-- --------------------------------------------------------

--
-- Table structure for table `webcamp_registrations`
--

CREATE TABLE IF NOT EXISTS `webcamp_registrations` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email_address` varchar(100) NOT NULL,
  `code_id` smallint(5) unsigned NOT NULL,
  `first_session` smallint(5) unsigned NOT NULL DEFAULT '0',
  `second_session` smallint(5) unsigned NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `date_registered` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `code_id` (`code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `workshops`
--

CREATE TABLE IF NOT EXISTS `workshops` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `facilatators` text NOT NULL,
  `year` year(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `workshops`
--

INSERT INTO `workshops` (`id`, `title`, `description`, `facilatators`, `year`) VALUES
(1, 'Jquery', 'Simple Jquery ', 'Yan Barreta', 2013),
(2, 'HTML and CSS', 'Basic html and css', 'Nick Aguilos', 2013),
(3, 'Web Development ', 'Basic web development using php.', 'Czar Pino', 2013),
(4, 'Version Control', 'Basic of version control', 'Farly Taboada', 2013);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `webcamp_registrations`
--
ALTER TABLE `webcamp_registrations`
  ADD CONSTRAINT `webcamp_registrations_ibfk_3` FOREIGN KEY (`code_id`) REFERENCES `codes` (`id`);
