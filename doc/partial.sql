-- phpMyAdmin SQL Dump
-- version 3.5.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 24, 2012 at 06:14 AM
-- Server version: 5.5.28
-- PHP Version: 5.4.8

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
-- Table structure for table `code`
--

CREATE TABLE IF NOT EXISTS `codes` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `code`
--

INSERT INTO `codes` (`id`, `code`, `owner`, `description`) VALUES
(1, 'CODEUP1001', 'UP', 'Code for UP. '),
(2, 'CODELNU2002', 'LNU', 'Code for LNU');

-- --------------------------------------------------------

--
-- Table structure for table `webcamp_registration`
--

CREATE TABLE IF NOT EXISTS `webcamp_registrations` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email_address` varchar(100) NOT NULL,
  `code_id` smallint(5) unsigned NOT NULL,
  `first_session` smallint(5) unsigned NOT NULL,
  `second_session` smallint(5) unsigned NOT NULL,
  `status` tinyint(1) NOT NULL,
  `date_registered` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `first_session` (`first_session`,`second_session`),
  KEY `second_session` (`second_session`),
  KEY `code_id` (`code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `workshop`
--

CREATE TABLE IF NOT EXISTS `workshops` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `description` text NOT NULL,
  `facilatators` text NOT NULL,
  `year` year(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `workshop`
--

INSERT INTO `workshops` (`id`, `title`, `description`, `facilatators`, `year`) VALUES
(1, 'Web Development ', 'Basic web development using php.', 'Czar Pino', 2013),
(2, 'Version Control', 'Basic of version control', 'Farly Taboada', 2013);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `webcamp_registration`
--
ALTER TABLE `webcamp_registrations`
  ADD CONSTRAINT `webcamp_registration_ibfk_1` FOREIGN KEY (`first_session`) REFERENCES `workshops` (`id`),
  ADD CONSTRAINT `webcamp_registration_ibfk_2` FOREIGN KEY (`second_session`) REFERENCES `workshops` (`id`),
  ADD CONSTRAINT `webcamp_registration_ibfk_3` FOREIGN KEY (`code_id`) REFERENCES `codes` (`id`);
