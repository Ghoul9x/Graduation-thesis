-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2021 at 12:51 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `restaurant`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `people` int(3) NOT NULL,
  `message` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`id`, `name`, `email`, `phone`, `date`, `time`, `people`, `message`) VALUES
(1, 'aaaaaa', 'aaa@gmail.com', '122131231231', '2021-05-05', '11:11:00', 1, '2123');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `active`) VALUES
(1, 'Món chính', 1),
(2, 'Món tráng miệng', 1),
(3, 'Đồ uống', 1);

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE `company` (
  `id` int(11) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `service_charge_value` varchar(255) NOT NULL,
  `vat_charge_value` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `currency` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`id`, `company_name`, `service_charge_value`, `vat_charge_value`, `address`, `phone`, `country`, `message`, `currency`) VALUES
(1, 'TruongSa', '1', '13', 'READING', '0914220132', 'VietNam', 'HSTS', 'VND');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL,
  `group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `permission` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `group_name`, `permission`) VALUES
(1, 'Super Administrator', 'a:32:{i:0;s:10:\"createUser\";i:1;s:10:\"updateUser\";i:2;s:8:\"viewUser\";i:3;s:10:\"deleteUser\";i:4;s:11:\"createGroup\";i:5;s:11:\"updateGroup\";i:6;s:9:\"viewGroup\";i:7;s:11:\"deleteGroup\";i:8;s:11:\"createStore\";i:9;s:11:\"updateStore\";i:10;s:9:\"viewStore\";i:11;s:11:\"deleteStore\";i:12;s:11:\"createTable\";i:13;s:11:\"updateTable\";i:14;s:9:\"viewTable\";i:15;s:11:\"deleteTable\";i:16;s:14:\"createCategory\";i:17;s:14:\"updateCategory\";i:18;s:12:\"viewCategory\";i:19;s:14:\"deleteCategory\";i:20;s:13:\"createProduct\";i:21;s:13:\"updateProduct\";i:22;s:11:\"viewProduct\";i:23;s:13:\"deleteProduct\";i:24;s:11:\"createOrder\";i:25;s:11:\"updateOrder\";i:26;s:9:\"viewOrder\";i:27;s:11:\"deleteOrder\";i:28;s:10:\"viewReport\";i:29;s:13:\"updateCompany\";i:30;s:11:\"viewProfile\";i:31;s:13:\"updateSetting\";}'),
(4, 'Members', 'a:9:{i:0;s:9:\"viewStore\";i:1;s:11:\"deleteStore\";i:2;s:9:\"viewTable\";i:3;s:11:\"deleteTable\";i:4;s:12:\"viewCategory\";i:5;s:11:\"viewProduct\";i:6;s:11:\"createOrder\";i:7;s:11:\"updateOrder\";i:8;s:9:\"viewOrder\";}'),
(5, 'Staff', 'a:6:{i:0;s:9:\"viewTable\";i:1;s:11:\"viewProduct\";i:2;s:11:\"createOrder\";i:3;s:11:\"updateOrder\";i:4;s:9:\"viewOrder\";i:5;s:11:\"viewProfile\";}');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `bill_no` varchar(255) NOT NULL,
  `date_time` varchar(255) NOT NULL,
  `gross_amount` varchar(255) NOT NULL,
  `service_charge_rate` varchar(255) NOT NULL,
  `service_charge_amount` varchar(255) NOT NULL,
  `vat_charge_rate` varchar(255) NOT NULL,
  `vat_charge_amount` varchar(255) NOT NULL,
  `discount` varchar(255) NOT NULL,
  `net_amount` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `table_id` int(11) NOT NULL,
  `paid_status` int(11) NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `bill_no`, `date_time`, `gross_amount`, `service_charge_rate`, `service_charge_amount`, `vat_charge_rate`, `vat_charge_amount`, `discount`, `net_amount`, `user_id`, `table_id`, `paid_status`, `store_id`) VALUES
(3, 'BILPR-4450', '1620229129', '200000.00', '1', '2000.00', '13', '26000.00', '1', '227999.00', 1, 3, 1, 0),
(5, 'BILPR-71A9', '1620290441', '200000.00', '1', '2000.00', '13', '26000.00', '', '228000.00', 1, 1, 1, 0),
(6, 'BILPR-A4BE', '1620290566', '500000.00', '1', '5000.00', '13', '65000.00', '10', '569990.00', 1, 2, 1, 0),
(7, 'BILPR-46EC', '1620584490', '20000.00', '1', '200.00', '13', '2600.00', '', '22800.00', 1, 1, 2, 0),
(9, 'BILPR-876F', '1620661540', '150000.00', '1', '1500.00', '13', '19500.00', '', '171000.00', 1, 4, 2, 0),
(10, 'BILPR-D58F', '1620836827', '390000.00', '1', '3900.00', '13', '50700.00', '', '444600.00', 1, 5, 2, 0),
(11, 'BILPR-EBE4', '1620838026', '1270000.00', '1', '12700.00', '13', '165100.00', '', '1447800.00', 1, 2, 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` varchar(255) NOT NULL,
  `rate` varchar(255) NOT NULL,
  `amount` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `qty`, `rate`, `amount`) VALUES
(5, 3, 19, '1', '200000', '200000.00'),
(21, 7, 20, '1', '20000', '20000.00'),
(22, 5, 19, '1', '200000', '200000.00'),
(24, 9, 18, '1', '150000', '150000.00'),
(25, 10, 18, '1', '150000', '150000.00'),
(26, 10, 20, '2', '20000', '40000.00'),
(27, 10, 7, '4', '50000', '200000.00'),
(28, 6, 18, '1', '150000', '150000.00'),
(29, 6, 18, '1', '150000', '150000.00'),
(30, 6, 12, '1', '200000', '200000.00'),
(31, 11, 17, '1', '600000', '600000.00'),
(32, 11, 16, '1', '650000', '650000.00'),
(33, 11, 20, '1', '20000', '20000.00');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` text NOT NULL,
  `store_id` text NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image` text NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `store_id`, `name`, `price`, `description`, `image`, `active`) VALUES
(5, '[\"2\"]', '[\"1\"]', 'Súp bào ngư', '50000', '<p>\r\nRất bổ dưỡng, có tác dụng trong việc tăng khí, hạ nhiệt, bổ thận, chống suy nhược cơ thể.\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/609280cf4272e.jpg', 1),
(6, '[\"2\"]', '[\"1\"]', 'Nem hải sản', '80000', '<p>\r\nNem hải sản chiên xù còn được pha trộn với xốt mayonnaise béo ngậy\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/609280c5161cd.jpg', 1),
(7, '[\"2\"]', '[\"1\"]', 'Nộm sứa tam vị', '50000', '<p>\r\nTổng hòa của ba vị: ngọt – chua – cay, món nộm sứa tam vị\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/6092810b49e0b.jpg', 1),
(8, '[\"2\"]', '[\"1\"]', 'Súp tôm kiểu thái', '55000', '<p>\r\nThành phần nguyên liệu, tới màu sắc thành phẩm đã làm mọi người hấp dẫn.\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/6092813c5f968.jpg', 1),
(9, '[\"1\"]', '[\"1\"]', 'Bào ngư', '170000', '<p>\r\nSashimi / Sốt Dầu Hào / Nướng Mỡ Hành / Sốt Hồng Xíu\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/6092816bb7585.jpg', 1),
(10, '[\"1\"]', '[\"1\"]', 'Cua thịt / Cua gạch', '200000', '<p>\r\nHấp / Rang Muối / Rang Me / Nướng Mọi / Ủ Muối\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/609281a82c616.jpg', 1),
(11, '[\"1\"]', '[\"1\"]', 'Cá hồi', '245000', '<p>\r\nSashimi / Nướng Sốt Chanh Leo / Chiên Sốt Mayonaise / Nấu Canh Chua /Lẩu\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/609281f2274db.jpg', 1),
(12, '[\"1\"]', '[\"1\"]', 'Cá mú', '200000', '<p>\r\nCá Mú Hồng Tự Nhiên / Cá Mú Sao Xanh / Cá Song Trân Châu / Cá Mú Chấm Đỏ\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/6092820eaf07d.jpg', 1),
(13, '[\"1\"]', '[\"1\"]', 'Cá diêu hồng', '200000', '<p>\r\nMón ngon tuyệt vời từ Cá Diêu Hồng là Hấp Xì Dầu / Chiên Giòn / Lẩu\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/60928252213e7.jpg', 1),
(14, '[\"1\"]', '[\"1\"]', 'Ốc móng tay', '85000', '<p>\r\nXào dăm tỏi /  Hấp sả ớt\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/6092828c39a6d.jpg', 1),
(15, '[\"1\"]', '[\"1\"]', 'Ốc vòi voi', '95000', '<i></i>Gỏi / Cháo / Bỏ lò phomai / Nướng mỡ hành / Xào hành răm / Xốt hồng xíu\r\n                        \r\n\r\n<br><br>', 'assets/images/product_image/609282c873cd2.jpg', 1),
(16, '[\"1\"]', '[\"1\"]', 'Tôm hùm bông', '650000', '<p>\r\nTiết Canh / Bỏ Lò Phomai / Rang Muối / Rang Me / Sashimi / Nướng Mọi\r\n\r\n<br></p>', 'assets/images/product_image/609282fb60642.jpg', 1),
(17, '[\"1\"]', '[\"1\"]', 'Tôm hùm baby đỏ', '600000', '<p>\r\nBỏ Lò Phomai / Rang Muối / Hấp Vang Trắng / Rang Muối / Nướng Mọi\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/60928328da20f.jpg', 1),
(18, '[\"3\"]', '[\"1\"]', 'F- Negro Amaro', '150000', '<p>\r\nMàu tím rất đầy đủ và sâu sắc, phong phú và phức hợp về hương thơm\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/609283570ffb7.jpg', 1),
(19, '[\"3\"]', '[\"1\"]', 'Rượu Vang Vindoro', '200000', '<p>\r\nMùi của nấm đen quý phái, nồng nàn mùi hoa quả chín, mứt quả đen\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/60928380aed13.png', 1),
(20, '[\"3\"]', '[\"1\"]', 'Nước ngọt', '20000', '<p>\r\nCoca / Pessi / 7Up / Twistter\r\n                        \r\n\r\n<br></p>', 'assets/images/product_image/6092f6cc0dbb9.png', 1);

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`id`, `name`, `active`) VALUES
(1, 'Trường sa', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `id` int(11) NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `capacity` varchar(255) NOT NULL,
  `available` int(11) NOT NULL,
  `active` int(11) NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tables`
--

INSERT INTO `tables` (`id`, `table_name`, `capacity`, `available`, `active`, `store_id`) VALUES
(1, 'aaaaa', '2', 2, 1, 1),
(2, 'bbbb', '4', 2, 1, 1),
(4, 'a', '6', 2, 1, 1),
(5, 'b', '4', 2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `gender` int(11) NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `firstname`, `lastname`, `phone`, `gender`, `store_id`) VALUES
(1, 'admin', '$2y$10$Y/8oI3vXQU8/fsjlRd0hOekjI8Ig0XiJeGiteTyCCHW7U03YhMs22', 'admin@admin.com', 'Nam', 'Nguyễn', '0963986616', 1, 0),
(7, 'aaaaaaaaaa', '$2y$10$d/ACJNmCwRv0rKUH.i9vgOigLtdy6lx.hI.pgqkFeHSbRGxfzfOKG', 'thea@gmail.com', 'aaaaaaaaa', 'aaaaaaaaaa', '231231523', 1, 0),
(8, 'nam12345', '$2y$10$aGgL9OoR5KWCoT7jDDu6JusmgzkngXBFWRBbqEKKuuXGJuYelMACK', 'theb@gmail.com', 'nam', 'nam', '131242341', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_group`
--

CREATE TABLE `user_group` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_group`
--

INSERT INTO `user_group` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1),
(7, 6, 4),
(8, 7, 4),
(9, 8, 5),
(10, 9, 4),
(11, 10, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `company`
--
ALTER TABLE `company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`table_id`,`store_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`group_id`),
  ADD KEY `group_id` (`group_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `company`
--
ALTER TABLE `company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tables`
--
ALTER TABLE `tables`
  ADD CONSTRAINT `tables_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_group`
--
ALTER TABLE `user_group`
  ADD CONSTRAINT `user_group_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
