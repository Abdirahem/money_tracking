-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 13, 2022 at 08:12 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tixraac_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transaction_id` int(11) NOT NULL,
  `transaction_type` varchar(20) NOT NULL,
  `transaction_title` varchar(40) NOT NULL,
  `transaction_value` double NOT NULL,
  `registered_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transaction_id`, `transaction_type`, `transaction_title`, `transaction_value`, `registered_date`, `user_id`) VALUES
(1, 'income', 'salary', 500, '2022-07-03 06:18:54', 7),
(2, 'income', 'Lottery', 1000, '2022-07-03 06:19:14', 7),
(3, 'expense', 'Univeristy fee', 450, '2022-07-03 06:19:39', 7),
(4, 'expense', 'lacagta biilka', 150, '2022-07-03 06:20:41', 8),
(5, 'income', 'award winning', 1500, '2022-07-03 06:21:02', 8),
(6, 'income', 'award winning ', 900, '2022-07-07 19:09:51', 7),
(7, 'expense', 'kkkl', 450, '2022-07-07 19:11:18', 7),
(8, 'income', 'hello world', 250, '2022-07-13 05:54:30', 7),
(9, 'expense', 'lacagta korontada', 40, '2022-07-13 05:56:52', 7),
(10, 'income', 'project deal', 1500, '2022-07-13 05:59:07', 8),
(11, 'expense', 'kids for gift', 250, '2022-07-13 05:59:19', 8),
(12, 'income', 'Salary', 2000, '2022-07-13 06:02:44', 9),
(13, 'expense', 'deyn gudid', 145, '2022-07-13 06:05:00', 10),
(14, 'income', 'bill', 450, '2022-07-13 06:05:13', 10),
(15, 'income', 'local home', 520, '2022-07-13 06:06:58', 10),
(16, 'expense', 'form for research', 70, '2022-07-13 06:07:39', 10);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `email` varchar(40) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `password` varchar(15) NOT NULL,
  `registered_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `email`, `fullname`, `password`, `registered_date`) VALUES
(7, 'osman@gmail.com', 'Osman Mohudin', 'osman123', '2022-07-03 06:17:52'),
(8, 'hem@gmail.com', 'Hem Mohamed', 'hem123', '2022-07-03 06:20:07'),
(9, 'khaled@gmail.com', 'Khaled abdirahman', '120', '2022-07-13 06:00:59'),
(10, 'shukri@gmail.com', 'Shukri Dahir', 'shukri123', '2022-07-13 06:04:20');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `xiriiriye_key` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transaction`
--
ALTER TABLE `transaction`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `xiriiriye_key` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
