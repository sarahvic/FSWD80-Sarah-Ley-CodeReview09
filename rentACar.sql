-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 11, 2019 at 02:46 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rentACar`
--

-- --------------------------------------------------------

--
-- Table structure for table `additionals`
--

CREATE TABLE `additionals` (
  `additionalsID` int(6) NOT NULL,
  `fk_insuranceID` int(6) DEFAULT NULL,
  `fk_damagesID` int(6) DEFAULT NULL,
  `prepaidFuel` enum('yes','no') DEFAULT NULL,
  `gps` enum('yes','no') DEFAULT NULL,
  `airConditioning` enum('yes','no') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `additionals`
--

INSERT INTO `additionals` (`additionalsID`, `fk_insuranceID`, `fk_damagesID`, `prepaidFuel`, `gps`, `airConditioning`) VALUES
(1, 3, 1, 'yes', 'yes', 'yes'),
(2, 2, 4, 'yes', 'no', 'no'),
(3, 1, 3, 'no', 'yes', 'no'),
(4, 4, 4, 'no', 'no', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `addressID` int(6) NOT NULL,
  `street` varchar(50) DEFAULT NULL,
  `houseNR` int(11) DEFAULT NULL,
  `fk_zipcode` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`addressID`, `street`, `houseNR`, `fk_zipcode`) VALUES
(1, 'clark st.', 56, 123099),
(2, 'gluckgasse', 5, 938475),
(3, 'sunshine drive', 989, 162374),
(4, 'burggasse', 9, 364758);

-- --------------------------------------------------------

--
-- Table structure for table `car`
--

CREATE TABLE `car` (
  `carID` int(6) NOT NULL,
  `make` varchar(50) DEFAULT NULL,
  `year` int(4) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `transmission` enum('automatic','manual') DEFAULT NULL,
  `fuel` enum('petrol','diesel') DEFAULT NULL,
  `fk_carAgencyNR` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `car`
--

INSERT INTO `car` (`carID`, `make`, `year`, `model`, `transmission`, `fuel`, `fk_carAgencyNR`) VALUES
(1, 'ford', 1994, 'focus', 'automatic', 'petrol', 1),
(2, 'porsche', 2016, '911', 'manual', 'diesel', 2),
(3, 'ferrari', 2019, 'Aperta Spider', 'manual', 'petrol', 3),
(4, 'bmw', 1992, 'E24 M6', 'automatic', 'petrol', 4);

-- --------------------------------------------------------

--
-- Table structure for table `carAgency`
--

CREATE TABLE `carAgency` (
  `agencyNR` int(6) NOT NULL,
  `fk_addressID` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `carAgency`
--

INSERT INTO `carAgency` (`agencyNR`, `fk_addressID`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customerID` int(6) NOT NULL,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telephone` int(11) DEFAULT NULL,
  `licenseNR` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `firstName`, `lastName`, `email`, `telephone`, `licenseNR`) VALUES
(1, 'Bob', 'Smith', 'bobsmith@gmail.com', 28337470, 28273485),
(2, 'Sarah', 'Jones', 'sjones98@gmail.com', 23837348, 3847230),
(3, 'Dennis', 'Peters', 'DennisP1993@yahoo.com', 2340923, 234290348),
(4, 'Victoria', 'Indiana', 'indygal98@gmail.com', 2394870, 892349);

-- --------------------------------------------------------

--
-- Table structure for table `damages`
--

CREATE TABLE `damages` (
  `damageNR` int(6) NOT NULL,
  `damage` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `damages`
--

INSERT INTO `damages` (`damageNR`, `damage`) VALUES
(1, 'cracked window'),
(2, 'flat tire'),
(3, 'dent in door'),
(4, 'dent in bumper');

-- --------------------------------------------------------

--
-- Table structure for table `insurance`
--

CREATE TABLE `insurance` (
  `insuranceNR` int(6) NOT NULL,
  `insuranceName` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `insurance`
--

INSERT INTO `insurance` (`insuranceNR`, `insuranceName`) VALUES
(1, 'driver'),
(2, 'car4U'),
(3, 'car4me'),
(4, 'safe1');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `invoiceNR` int(6) NOT NULL,
  `fk_paymentNR` int(6) DEFAULT NULL,
  `totalCharge` float DEFAULT NULL,
  `fk_additionalsID` int(6) DEFAULT NULL,
  `paymentDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`invoiceNR`, `fk_paymentNR`, `totalCharge`, `fk_additionalsID`, `paymentDate`) VALUES
(1, 1, 982, 3, '2019-11-01'),
(2, 2, 234, 4, '2019-11-03'),
(3, 3, 777.9, 1, '2019-10-11'),
(4, 4, 455.78, 2, '2019-10-24');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `paymentNR` int(6) NOT NULL,
  `creditCardNR` int(11) DEFAULT NULL,
  `securityCode` int(3) DEFAULT NULL,
  `fk_customerID` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`paymentNR`, `creditCardNR`, `securityCode`, `fk_customerID`) VALUES
(1, 123498, 324, 1),
(2, 98348, 234, 3),
(3, 9897234, 232, 2),
(4, 9845938, 997, 4);

-- --------------------------------------------------------

--
-- Table structure for table `reservation`
--

CREATE TABLE `reservation` (
  `reservationNR` int(6) NOT NULL,
  `pickUpDate` date DEFAULT NULL,
  `returnDate` date DEFAULT NULL,
  `fk_carID` int(6) DEFAULT NULL,
  `fk_customerID` int(6) DEFAULT NULL,
  `fk_pickUpAddress` int(6) DEFAULT NULL,
  `fk_returnAddress` int(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reservation`
--

INSERT INTO `reservation` (`reservationNR`, `pickUpDate`, `returnDate`, `fk_carID`, `fk_customerID`, `fk_pickUpAddress`, `fk_returnAddress`) VALUES
(1, '2019-10-24', '2019-11-29', 4, 1, 1, 1),
(2, '2019-10-15', '2019-11-01', 3, 3, 4, 4),
(3, '2019-11-01', '2019-11-07', 1, 2, 2, 2),
(4, '2019-10-16', '2019-10-31', 2, 4, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `zipcode`
--

CREATE TABLE `zipcode` (
  `zip` int(6) NOT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `zipcode`
--

INSERT INTO `zipcode` (`zip`, `city`, `state`, `country`) VALUES
(123099, 'Chicago', 'Illinois', 'USA'),
(162374, 'Los Angeles', 'California', 'USA'),
(364758, 'Bremen', 'Bremen', 'Germany'),
(938475, 'Vienna', 'Vienna', 'Austria');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `additionals`
--
ALTER TABLE `additionals`
  ADD PRIMARY KEY (`additionalsID`),
  ADD KEY `fk_insuranceID` (`fk_insuranceID`),
  ADD KEY `fk_damagesID` (`fk_damagesID`);

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`addressID`),
  ADD KEY `fk_zipcode` (`fk_zipcode`);

--
-- Indexes for table `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`carID`),
  ADD KEY `fk_carAgencyNR` (`fk_carAgencyNR`);

--
-- Indexes for table `carAgency`
--
ALTER TABLE `carAgency`
  ADD PRIMARY KEY (`agencyNR`),
  ADD KEY `fk_addressID` (`fk_addressID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customerID`);

--
-- Indexes for table `damages`
--
ALTER TABLE `damages`
  ADD PRIMARY KEY (`damageNR`);

--
-- Indexes for table `insurance`
--
ALTER TABLE `insurance`
  ADD PRIMARY KEY (`insuranceNR`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoiceNR`),
  ADD KEY `fk_paymentNR` (`fk_paymentNR`),
  ADD KEY `fk_additionalsID` (`fk_additionalsID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`paymentNR`),
  ADD KEY `fk_customerID` (`fk_customerID`);

--
-- Indexes for table `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservationNR`),
  ADD KEY `fk_carID` (`fk_carID`),
  ADD KEY `fk_pickUpAddress` (`fk_pickUpAddress`),
  ADD KEY `fk_returnAddress` (`fk_returnAddress`),
  ADD KEY `fk_customerID` (`fk_customerID`);

--
-- Indexes for table `zipcode`
--
ALTER TABLE `zipcode`
  ADD PRIMARY KEY (`zip`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `additionals`
--
ALTER TABLE `additionals`
  MODIFY `additionalsID` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `addressID` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `car`
--
ALTER TABLE `car`
  MODIFY `carID` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `carAgency`
--
ALTER TABLE `carAgency`
  MODIFY `agencyNR` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customerID` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `insurance`
--
ALTER TABLE `insurance`
  MODIFY `insuranceNR` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `invoiceNR` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `paymentNR` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reservationNR` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `additionals`
--
ALTER TABLE `additionals`
  ADD CONSTRAINT `additionals_ibfk_1` FOREIGN KEY (`fk_insuranceID`) REFERENCES `insurance` (`insuranceNR`),
  ADD CONSTRAINT `additionals_ibfk_2` FOREIGN KEY (`fk_insuranceID`) REFERENCES `insurance` (`insuranceNR`),
  ADD CONSTRAINT `additionals_ibfk_3` FOREIGN KEY (`fk_damagesID`) REFERENCES `damages` (`damageNR`);

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`fk_zipcode`) REFERENCES `zipcode` (`zip`);

--
-- Constraints for table `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `car_ibfk_1` FOREIGN KEY (`fk_carAgencyNR`) REFERENCES `carAgency` (`agencyNR`);

--
-- Constraints for table `carAgency`
--
ALTER TABLE `carAgency`
  ADD CONSTRAINT `caragency_ibfk_1` FOREIGN KEY (`fk_addressID`) REFERENCES `address` (`addressID`);

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`fk_paymentNR`) REFERENCES `payment` (`paymentNR`),
  ADD CONSTRAINT `invoice_ibfk_2` FOREIGN KEY (`fk_additionalsID`) REFERENCES `additionals` (`additionalsID`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`fk_customerID`) REFERENCES `customer` (`customerID`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`fk_carID`) REFERENCES `car` (`carID`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`fk_pickUpAddress`) REFERENCES `address` (`addressID`),
  ADD CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`fk_returnAddress`) REFERENCES `address` (`addressID`),
  ADD CONSTRAINT `reservation_ibfk_4` FOREIGN KEY (`fk_customerID`) REFERENCES `customer` (`customerID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
