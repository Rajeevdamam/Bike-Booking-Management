-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 10, 2018 at 05:58 PM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 5.6.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bike_db`
--
CREATE DATABASE IF NOT EXISTS `bike_db` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bike_db`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_order` (IN `p_inventory_id` INT(2), IN `p_u_id` INT(2), IN `p_ord_price` INT(12))  BEGIN
INSERT INTO orders(inventory_id, u_id, ord_price) VALUES(p_inventory_id ,p_u_id, p_ord_price*1.18);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `idcompany` int(2) NOT NULL,
  `company_name` varchar(45) DEFAULT NULL,
  `logo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`idcompany`, `company_name`, `logo`) VALUES
(1, 'Kawasaki', 'kawasaki.jpg'),
(2, 'KTM', 'ktm.jpg'),
(3, 'Yamaha', 'yamaha.jpg'),
(4, 'Royal Enfield', 'enfield.jpg'),
(5, 'Suzuki', 'suzuki.jpg'),
(11, 'Aprilia', 'aprlogo.jpg'),
(12, 'Vespa', 'veslogo.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `idinventory` int(2) NOT NULL,
  `model_no` varchar(45) DEFAULT NULL,
  `engine` varchar(45) DEFAULT NULL,
  `stroke` int(11) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `price` int(12) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `p_id` int(2) DEFAULT NULL,
  `displacement` varchar(45) DEFAULT NULL,
  `transmission` varchar(45) DEFAULT NULL,
  `torque` varchar(45) DEFAULT NULL,
  `brakes` varchar(45) DEFAULT NULL,
  `comp_id` int(2) DEFAULT NULL,
  `image` varchar(45) NOT NULL,
  `stock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`idinventory`, `model_no`, `engine`, `stroke`, `color`, `price`, `year`, `p_id`, `displacement`, `transmission`, `torque`, `brakes`, `comp_id`, `image`, `stock`) VALUES
(1, 'z900', 'In-Line Four, 4-stroke, 16-Valves, DOHC', 4, 'red,green,black', 768000, 2018, 10, '948cc', 'manual', '98.6 N.m @ 7700 rpm', 'Disc', 1, 'z900.jpg', 4),
(3, 'z650', 'Parallel Twin, 4-stroke, 8-Valves, DOHC', 4, 'red,green,black', 499000, 2018, 10, '649cc', 'manual', '65.7 Nm @ 6500 rpm', 'Disc', 1, 'z650-1.jpg', 11),
(5, 'Duke 390', '1-Cylinder, 4-Stroke Engine', 4, 'orange,white,black', 242000, 2018, 10, '373.2 cc', 'manual', '37 Nm @ 7000 rpm', 'Disc', 2, '390.jpg', 45),
(6, 'Duke 200', 'Single Cylinder, 4 Stroke, DOHC Engine', 4, 'orange,white,black', 156000, 2018, 10, '199.5cc', 'manual', '19.2 Nm @ 8000 rpm', 'Disc', 2, '200.jpg', 12),
(9, 'YZF R1', 'Forward-Inclined Parallel 4-Cylinder, 4-Strok', 4, 'red,blue,white,black,grey', 1816000, 2018, 10, '998 cc', 'manual', '112.4 Nm @ 11500 rpm', 'Disc', 3, 'r1m.jpg', 13),
(13, 'YZF R15 V3', 'Single Cylinder, 4-Stroke, 4-Valve, SOHC', 4, 'red,blue,black,grey', 127000, 2018, 10, '155 cc', 'manual', '15 Nm @ 8500 rpm', 'Disc', 3, 'r15.jpg', 64),
(14, 'Himalyan', 'Single Cylinder, 4 stroke, Air cooled, SOHC, ', 4, 'red,blue,black,grey', 159000, 2018, 10, '411cc', 'manual', '32 Nm @ 4250 rpm', 'Disc', 4, 'himalayan.jpg', 33),
(16, 'Classic 350', 'Single Cylinder, 4 Stroke, Twinspark', 4, 'red,blue,black,grey', 139000, 2017, 10, '346cc', 'manual', '28 Nm @ 4000 rpm', 'front-disc,rear-drum', 4, 'c350.jpg', 31),
(18, 'GSX R1000R', 'In-line 4-Cylinder, 4-Stroke, DOHC', 4, 'blue,white,black', 1990000, 2018, 10, '999.8 cc', 'manual', '117.6 Nm @ 10800 rpm', 'Disc', 5, 'gsx1000.jpg', 4),
(19, 'Gixxer', 'Single Cylinder, 4-Stroke, 2-Valve, SOHC', 4, 'blue,white,black,red', 83057, 2016, 10, '154.9 cc', 'manual', '14 Nm @ 6000 rpm', 'front-disc,rear-drum', 5, 'gixxer.jpg', 23),
(20, 'SR-150', 'Single Cylinder, 3-Valves', 2, 'black,white', 71210, 2017, 11, '154.8 cc', 'Automatic', '10.9 Nm @ 5000 rpm', 'front-disc,rear-drum', 11, 'aprilia.jpg', 50),
(21, 'Notte-125', 'Air Cooled, Single Cylinder, 4-Stroke, 3-Valv', 4, 'red,orange,black,white,yellow', 70009, 2017, 11, '125 cc', 'Automatic', '10.6 Nm @ 6000 rpm', 'drum', 12, 'vespa.jpg', 34);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(3) NOT NULL,
  `inventory_id` int(2) NOT NULL,
  `u_id` int(2) NOT NULL,
  `ord_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ord_price` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `inventory_id`, `u_id`, `ord_date`, `ord_price`) VALUES
(13, 1, 1, '2018-12-02 12:45:34', 768000),
(14, 1, 1, '2018-12-02 12:45:54', 906240),
(17, 1, 1, '2018-12-10 22:27:05', 906240);

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `update_order` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
    UPDATE inventory
         SET stock = stock - 1
       WHERE idinventory = NEW.inventory_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_type`
--

CREATE TABLE `product_type` (
  `product_id` int(2) NOT NULL,
  `product_typecol` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product_type`
--

INSERT INTO `product_type` (`product_id`, `product_typecol`) VALUES
(10, 'bikes'),
(11, 'scooters'),
(12, 'cars');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `rating_id` int(11) NOT NULL,
  `rating` int(1) NOT NULL,
  `feedback` longtext NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `ui_id` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(2) NOT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `address` varchar(60) DEFAULT NULL,
  `is_admin` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `phone`, `email`, `password`, `gender`, `address`, `is_admin`) VALUES
(1, 'Damam', '123456789', 'damam@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '1', 'Dr Rajkumar road', 1),
(3, 'rajeev', '9964532579', '7@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', '1', '#759/29 6TH BLOCK RAJAJINAGAR', 0),
(7, '123', '123', 'abc@xyz.co', '202cb962ac59075b964b07152d234b70', '1', '123', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`idcompany`),
  ADD UNIQUE KEY `idcompany_UNIQUE` (`idcompany`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`idinventory`),
  ADD UNIQUE KEY `idinventory_UNIQUE` (`idinventory`),
  ADD KEY `p_id` (`p_id`),
  ADD KEY `comp_id` (`comp_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `inventory_id` (`inventory_id`),
  ADD KEY `u_id` (`u_id`);

--
-- Indexes for table `product_type`
--
ALTER TABLE `product_type`
  ADD PRIMARY KEY (`product_id`),
  ADD UNIQUE KEY `idproduct_type_UNIQUE` (`product_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`rating_id`),
  ADD KEY `ui_id` (`ui_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_id_UNIQUE` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `idcompany` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `idinventory` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`p_id`) REFERENCES `product_type` (`product_id`),
  ADD CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`comp_id`) REFERENCES `company` (`idcompany`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`idinventory`),
  ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`u_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`ui_id`) REFERENCES `user` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
