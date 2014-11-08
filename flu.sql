-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2014 at 08:28 PM
-- Server version: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `flu`
--

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
`id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `user_id` varchar(100) NOT NULL,
  `profile_pic` varchar(200) DEFAULT NULL,
  `visibility` char(1) NOT NULL DEFAULT 'y',
  `admin` char(1) NOT NULL DEFAULT 'n',
  `register_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `password` varchar(100) NOT NULL,
  `email_address` varchar(100) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `middle_name`, `user_id`, `profile_pic`, `visibility`, `admin`, `register_date`, `password`, `email_address`) VALUES
(1, 'vivek bharath', 'akupatni', NULL, 'vivekb88', NULL, 'y', 'y', '2014-10-06 12:43:35', 'vivekb88', ''),
(2, 'vivek', 'vivek', '', 'abc', 'abc_03656_athabascafalls_2880x1800.jpg', 'n', 'n', '2014-10-12 00:25:41', 'abc', ''),
(3, 'vivek', 'vivek', NULL, 'vivek_lol', 'vivek_lol_20130503_171936.jpg', 'n', 'n', '2014-10-12 01:14:46', 'a', ''),
(4, 'asdasdasd', 'asda', 'asdasadasd', 'zz', 'zz_20130721_160720.jpg', 'n', 'n', '2014-10-12 01:27:58', 'a', ''),
(5, 'asa', 'as', 'as', 'ass', 'ass_', 'y', 'n', '2014-10-12 01:31:07', 'a', ''),
(6, 'asdas', 'asdas', 'asdas', 'last', 'last_', 'y', 'n', '2014-10-12 01:32:22', 'final', ''),
(7, 'vivke', 'vivke', NULL, 'working', NULL, 'n', 'n', '2014-10-12 01:34:08', 'working', ''),
(8, 'sasd', 'asdsa', NULL, 'asasas', NULL, 'y', 'n', '2014-10-12 01:43:01', '1', ''),
(9, 'vivke', 'asasd', NULL, 'zasasas', NULL, 'n', 'n', '2014-10-12 13:45:07', '1', ''),
(10, 'vivek', 'asdasd', 'asdsa', 'tig', NULL, 'n', 'n', '2014-10-13 01:21:03', '1', ''),
(12, 'asd', 'asdsa', 'asd', 'asdasmonkey', NULL, 'n', 'n', '2014-10-13 02:00:00', '1234', ''),
(13, 'asdd', 'asdd', 'asdd', 'asdd', NULL, 'n', 'n', '2014-10-13 21:04:46', 'asdd', ''),
(14, 'hey', 'dude', 'lil', 'hey', 'hey_deadpool.png', 'y', 'n', '2014-10-13 23:25:54', 'hey', ''),
(15, 'ds', 'ds', 'ds', 'ds', NULL, 'n', 'n', '2014-10-14 00:32:38', 'ds', ''),
(16, 'asdad', 'asdsa', NULL, 'vivekb1988', NULL, 'n', 'n', '2014-10-14 04:33:52', 'buddY181', ''),
(17, 'vive', 'adas', 'sdsa', 'vivek', NULL, 'n', 'n', '2014-10-14 05:09:35', 'buddY181', ''),
(18, 'demo', 'demo', NULL, 'demo', NULL, 'y', 'n', '2014-10-21 20:42:47', 'demo', ''),
(19, 'demo', 'user', NULL, 'test', NULL, 'y', 'n', '2014-10-22 21:21:07', '1234', ''),
(21, 'ambi', 'lol', NULL, 'ambi', NULL, 'y', 'n', '2014-10-24 20:37:23', 'ambi', ''),
(22, 'vivekb88', 'vivekb88', NULL, 'testabc', NULL, 'y', 'n', '2014-10-27 16:19:05', 'testabc', ''),
(23, 'vivekb88', 'asdasd', NULL, 'zzz', NULL, 'n', 'n', '2014-11-04 23:24:11', 'zzz', ''),
(24, 'Jonathon', 'Hellmann', 'D', 'jonatho7', NULL, 'y', 'n', '2014-11-07 20:12:29', 'pass', 'jonatho7@vt.edu'),
(25, 'Harshal', 'Hayatnagarkar', NULL, 'harshalh', NULL, 'y', 'n', '2014-11-07 20:17:08', 'pass', 'harshalh@vt.edu'),
(26, 'Sarang', 'Joshi', NULL, 'sarang87', NULL, 'y', 'n', '2014-11-07 20:17:43', 'pass', 'sarang87@vt.edu');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=27;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
