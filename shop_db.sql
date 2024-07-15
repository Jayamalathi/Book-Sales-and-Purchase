-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 19, 2023 at 04:31 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shop_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `pid` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` int(5) NOT NULL,
  `quantity` int(25) NOT NULL,
  `image` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `name` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `number` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`id`, `user_id`, `name`, `email`, `number`, `message`) VALUES
(14, 18, 'jayamalathi j', 'jayamalathij.23mca@kongu.edu', '7708781245', 'satisfied service');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(5) NOT NULL,
  `user_id` int(5) NOT NULL,
  `name` varchar(25) NOT NULL,
  `number` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `method` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `total_products` varchar(50) NOT NULL,
  `order_items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `total_price` int(10) NOT NULL,
  `placed_on` varchar(50) NOT NULL,
  `payment_status` varchar(20) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `name`, `number`, `email`, `method`, `address`, `total_products`, `order_items`, `total_price`, `placed_on`, `payment_status`) VALUES
(19, 18, 'jayamalathi', '7708781245', 'jayamalathij.23mca@kongu.edu', 'cash on delivery', 'flat no. 12, 2, coimbatore, india - 642201', ', PHP Programming (1) , agni siragugal (1) ', '', 1780, '13-Dec-2023', 'pending'),
(21, 20, 'dummy', '9445135754', 'dummy@gmail.com', 'cash on delivery', 'flat no. 6786fgf, sdfdsfsdf, dfsdfr, India - 5687787', ', java programming (2) ', '', 1400, '18-Dec-2023', 'pending'),
(22, 20, 'dummy', '8798564546', 'dummy@gmail.com', 'cash on delivery', 'flat no. 6786fgf, sdfdsfsdf, dfsdfr, India - 454645', ', java programming (3) ', '', 2100, '18-Dec-2023', 'pending');

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `orderr_ad` AFTER DELETE ON `orders` FOR EACH ROW BEGIN

DELETE FROM order_items WHERE order_id=OLD.id;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `oi_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `created_time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `order_items`
--
DELIMITER $$
CREATE TRIGGER `order_item_ad` BEFORE DELETE ON `order_items` FOR EACH ROW BEGIN

IF (OLD.qty>0) THEN
	UPDATE products SET in_stock=in_stock+OLD.qty WHERE id=OLD.pid LIMIT 1;
END IF;

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `order_item_ai` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN

IF (NEW.qty>0) THEN
	UPDATE products SET in_stock=in_stock-NEW.qty WHERE id=NEW.pid LIMIT 1;
END IF;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `in_stock` int(11) NOT NULL,
  `details` varchar(255) NOT NULL,
  `price` int(5) NOT NULL,
  `image` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `in_stock`, `details`, `price`, `image`) VALUES
(21, 'java programming', 15, 'The cover illustration for the Java Programming book', 700, 'Java_Programming.jpg'),
(29, 'dfgfdgd', 68, 'aqwertyi', 78, 'Bravehearts of Bravehearts of Bharat.jpg'),
(30, 'lgj', 0, 'kcjohwucpc', 200, 'images.jpg'),
(31, 'thealchemist', 0, ' novel', 780, 'thealchemist.jpg'),
(32, 'Tholkappiyam', 0, 'Tholkappiyam is the oldest Tamil literature. It was composed 2000 years ago.The Tolkappiyam deals with ilakkanam (grammar) in three books (atikaram), each with nine chapters (iyal) of different sizes.', 1200, 'tholkappiyam.jpg'),
(33, 'PHP Programming', 65, 'In this book PHP Programming | The Complete Guide | 2022, PHP is a server-side programming language mainly used for web development and is also used as a general purpose programming language. It has become a rage in the Internet world. PHP Programming | T', 890, 'php-programming.webp'),
(34, 'artificial Intelligence', 0, 'A hands-on roadmap to using Python for artificial intelligence programming In Practical Artificial Intelligence Programming with Python: From Zero to Hero, veteran educator and photophysicist Dr. Perry Xiao delivers a thorough introduction to one of the m', 3277, 'artificial.webp'),
(35, 'Big Data', 0, 'The best-selling author of Big Data is back, this time with a unique and in-depth insight into how specific companies use big data.', 900, 'bigdata.jpg'),
(36, 'திருக்குறள்(Thirukkural)', 0, 'The Tirukkural or Thirukkural ( literally Sacred Verses), or shortly the Kural, is a classic Tamil sangam literature consisting of 1330 couplets or kurals, dealing with the everyday virtues of an individual.', 300, 'thirukkural.jpg'),
(37, 'RS Agarwal quantitative aptitude', 0, ' Best aptitude book for competitive exams ', 890, 'rs agarwal.jpg'),
(38, 'agni siragugal', 0, 'Abdul kalam sir journey from childhood days to the day he became scientist in the Indian Space Research Sector and eventually the 11th President of India, the book gives a detailed insight into the life of the \'Missile Man\' of India.', 890, 'agni siragugal.jpg'),
(40, 'Internet of things', 0, 'This book introduces the Internet of Things (IoT), which is the convergence of connecting people, things, data and processes; it is transforming our life, business and everything in between.', 900, 'iot.jpg'),
(43, 'c programming', 0, 'The C Programming Language (sometimes termed K&R, after its authors\' initials) is a computer programming book written by Brian Kernighan and Dennis Ritchie', 650, 'c program.png'),
(44, 'story books', 0, 'Tamil story book for children', 100, 'story.jpg'),
(45, 'English story books', 0, 'English story book for children', 150, 'storye.jpg'),
(46, 'The Reluctant Detective', 0, 'Crime fiction, detective story, murder mystery, mystery novel, and police novel are terms used to describe narratives that centre on criminal acts and especially on the investigation, either by an amateur or a professional detective, of a crime, often a m', 1000, 'crime.jpg'),
(47, 'block chain technology', 0, 'Blockchain Technology explains blockchain in simple terms, guiding the reader through the nuances of how this revolutionary concept builds on the distributed database system to redefine how we store, move and update data.', 1200, 'bct.jpg'),
(48, 'Computer Networks', 0, 'The book provides a comprehensive introduction to computer networks, including a history of computer networks, network architecture and models, and switching techniques. It goes on to cover the various principles, standards, and protocols developed for 1.', 900, 'cn1.jpg'),
(49, 'Open Source Technology', 0, 'Conversational and easy to understand language has been used. Diagrams and illustrations are self explanatory. The summary given at the end of each chapter helps in reviewing the whole chapter in a short time. It provides deep knowledge of Open Source Tec', 200, 'ost.jpg'),
(50, 'The Glass Slipper', 0, 'English story book', 400, 'the story.jpg'),
(51, 'The Floating Girl', 0, 'The Floating Girls: A Novel by Lo Patrick is available now for quick shipment to any U.S. location! This book, published in 2009 is in good condition or better. Over the years we have learned how to provide our customers with cheap prices on books and to ', 780, 'floating girl.jpg'),
(52, 'English Grammer ', 0, 'English basic grammer book ', 1700, 'english.jpg'),
(53, 'Software engineering ', 0, 'This book is very useful for all the students of universities / colleges from all over India, who are preparing for “Software Engineering” exam. Book covers maximum syllabus in the form of simple questions and answers.', 750, 'software.png');

-- --------------------------------------------------------

--
-- Table structure for table `resale`
--

CREATE TABLE `resale` (
  `id` int(5) NOT NULL,
  `username` varchar(25) NOT NULL,
  `email` varchar(50) NOT NULL,
  `contact` int(10) NOT NULL,
  `bookname` varchar(50) NOT NULL,
  `author` varchar(25) NOT NULL,
  `price` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `resale`
--

INSERT INTO `resale` (`id`, `username`, `email`, `contact`, `bookname`, `author`, `price`) VALUES
(1, 'c# programming', 'jayamalathijaganathan@gmail.com', 2147483647, 'hbyo', 'oivioo', 400);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `user_type` varchar(20) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `user_type`) VALUES
(17, 'admin', 'admin@gmail.com', '0e7517141fb53f21ee439b355b5a1d0a', 'admin'),
(18, 'jayamalathi J', 'jayamalathij.23mca@kongu.edu', '1d7b217127d82ea1eac7e3b92090a463', 'user'),
(19, 'malathi', 'malathi@gmail.com', 'malathi@123', 'user'),
(20, 'dummy', 'dummy@gmail.com', 'ca6dc24fb68693b7092d5b75c0a8ee50', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(100) NOT NULL,
  `user_id` int(100) NOT NULL,
  `pid` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int(100) NOT NULL,
  `image` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`id`, `user_id`, `pid`, `name`, `price`, `image`) VALUES
(62, 17, 21, 'java programming', 700, 'Java_Programming.jpg'),
(63, 18, 31, 'thealchemist', 780, 'thealchemist.jpg'),
(65, 20, 29, 'zsdggjhjk', 2346, 'Bravehearts of Bravehearts of Bharat.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`oi_id`),
  ADD KEY `order_item_link_fk` (`pid`),
  ADD KEY `item_order_link_fk` (`order_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resale`
--
ALTER TABLE `resale`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `oi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `resale`
--
ALTER TABLE `resale`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_item_link_fk` FOREIGN KEY (`pid`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
