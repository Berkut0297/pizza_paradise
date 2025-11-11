-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Nov 11. 10:15
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `pizzaparadise`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `addresses`
--

CREATE TABLE `addresses` (
  `address_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `city` varchar(50) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `house_number` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `addresses`
--

INSERT INTO `addresses` (`address_id`, `user_id`, `city`, `street`, `postal_code`, `house_number`) VALUES
(1, 1, 'Budapest', 'Kossuth Lajos utca', '1053', '12'),
(2, 2, 'Szeged', 'Tisza Lajos körút', '6722', '45'),
(3, 3, 'Budapest', 'Andrássy út', '1061', '15'),
(4, 4, 'Pécs', 'Rákóczi út', '7621', '2A');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `allergens`
--

CREATE TABLE `allergens` (
  `allergen_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `allergens`
--

INSERT INTO `allergens` (`allergen_id`, `name`, `description`) VALUES
(1, 'Glutén', 'Búzalisztet tartalmaz.'),
(2, 'Tej', 'Tejfehérjét és laktózt tartalmaz.'),
(3, 'Tojás', 'Tojásfehérjét tartalmaz.'),
(4, 'Szójabab', 'Szóját tartalmaz.'),
(5, 'Mogyoró', 'Nyomokban mogyorót tartalmazhat.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `cart_id` int(11) DEFAULT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `status` enum('pending','in_progress','delivered','cancelled') DEFAULT 'pending',
  `total_price` decimal(10,2) DEFAULT NULL,
  `payment_method` enum('cash','card','online') DEFAULT 'cash'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `orders`
--

INSERT INTO `orders` (`order_id`, `user_id`, `address_id`, `cart_id`, `order_date`, `status`, `total_price`, `payment_method`) VALUES
(1, 1, 1, 1, '2025-11-05 18:30:00', 'delivered', 4090.00, 'card'),
(2, 2, 2, 2, '2025-11-06 12:45:00', 'in_progress', 3240.00, 'cash');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders_item`
--

CREATE TABLE `orders_item` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `topping_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `subtotal` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `orders_item`
--

INSERT INTO `orders_item` (`order_item_id`, `order_id`, `product_id`, `topping_id`, `quantity`, `subtotal`) VALUES
(1, 1, 3, 7, 1, 2990.00),
(2, 1, 6, NULL, 2, 1100.00),
(3, 2, 4, 5, 1, 2690.00),
(4, 2, 7, NULL, 1, 550.00);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_date` datetime DEFAULT current_timestamp(),
  `amount` decimal(10,2) NOT NULL,
  `payment_status` enum('pending','completed','failed') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `payments`
--

INSERT INTO `payments` (`payment_id`, `order_id`, `payment_date`, `amount`, `payment_status`) VALUES
(1, 1, '2025-11-05 18:35:00', 4090.00, 'completed'),
(2, 2, '2025-11-06 12:50:00', 3240.00, 'pending');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(8,2) NOT NULL,
  `type_id` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `available` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `type_id`, `image_url`, `available`) VALUES
(1, 'Margherita Pizza', 'Paradicsomszósz, mozzarella, bazsalikom', 2290.00, 1, 'images/margherita.jpg', 1),
(2, 'SonGoKu Pizza', 'Sonka, gomba, kukorica, sajt', 2790.00, 1, 'images/songoku.jpg', 1),
(3, 'Magyaros Pizza', 'Kolbász, szalámi, lilahagyma, csípős paprika, sajt', 2990.00, 1, 'images/magyaros.jpg', 1),
(4, 'Vegetáriánus Pizza', 'Gomba, kukorica, paprika, olívabogyó, sajt', 2690.00, 1, 'images/vegetarian.jpg', 1),
(5, 'BBQ Csirkés Pizza', 'BBQ-szósz, grillezett csirke, hagyma, sajt', 2990.00, 1, 'images/bbq.jpg', 1),
(6, 'Coca-Cola 0.5L', 'Szénsavas üdítőital', 550.00, 2, 'images/cocacola.jpg', 1),
(7, 'Fanta 0.5L', 'Narancs ízű üdítőital', 550.00, 2, 'images/fanta.jpg', 1),
(8, 'Somlói galuska', 'Hagyományos magyar desszert tejszínhabbal', 990.00, 3, 'images/somloi.jpg', 1),
(9, 'Fokhagymás kenyeres kosár', 'Friss bagett fokhagymás vajjal', 750.00, 4, 'images/garlicbread.jpg', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `product_allergens`
--

CREATE TABLE `product_allergens` (
  `product_id` int(11) NOT NULL,
  `allergen_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `product_allergens`
--

INSERT INTO `product_allergens` (`product_id`, `allergen_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(5, 1),
(5, 2),
(8, 1),
(8, 2),
(8, 3),
(9, 1),
(9, 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `product_toppings`
--

CREATE TABLE `product_toppings` (
  `product_id` int(11) NOT NULL,
  `topping_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `product_toppings`
--

INSERT INTO `product_toppings` (`product_id`, `topping_id`) VALUES
(1, 6),
(2, 2),
(2, 3),
(2, 4),
(3, 1),
(3, 7),
(3, 8),
(4, 3),
(4, 4),
(4, 5),
(5, 6),
(5, 8);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `shopping_cart`
--

CREATE TABLE `shopping_cart` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `shopping_cart`
--

INSERT INTO `shopping_cart` (`cart_id`, `user_id`, `created_at`) VALUES
(1, 1, '2025-11-11 10:10:05'),
(2, 2, '2025-11-11 10:10:05');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `shopping_cart_items`
--

CREATE TABLE `shopping_cart_items` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `topping_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `shopping_cart_items`
--

INSERT INTO `shopping_cart_items` (`cart_item_id`, `cart_id`, `product_id`, `quantity`, `topping_id`) VALUES
(1, 1, 3, 1, 7),
(2, 1, 6, 2, NULL),
(3, 2, 4, 1, 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `toppings`
--

CREATE TABLE `toppings` (
  `topping_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` decimal(6,2) DEFAULT 0.00,
  `is_spicy` tinyint(1) DEFAULT 0,
  `is_vegan` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `toppings`
--

INSERT INTO `toppings` (`topping_id`, `name`, `price`, `is_spicy`, `is_vegan`) VALUES
(1, 'Szalámi', 350.00, 1, 0),
(2, 'Sonka', 300.00, 0, 0),
(3, 'Gomba', 250.00, 0, 1),
(4, 'Kukorica', 200.00, 0, 1),
(5, 'Olívabogyó', 200.00, 0, 1),
(6, 'Extra sajt', 300.00, 0, 1),
(7, 'Csípős paprika', 150.00, 1, 1),
(8, 'Hagyma', 100.00, 0, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `type`
--

CREATE TABLE `type` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `type`
--

INSERT INTO `type` (`type_id`, `type_name`) VALUES
(1, 'Pizza'),
(2, 'Ital'),
(3, 'Desszert'),
(4, 'Kiegészítő');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('customer','admin','courier') DEFAULT 'customer',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`user_id`, `username`, `password_hash`, `email`, `full_name`, `phone`, `role`, `created_at`) VALUES
(1, 'peter88', 'hashed_pw1', 'peter88@example.com', 'Kovács Péter', '+36201234567', 'customer', '2025-11-11 10:10:05'),
(2, 'anna92', 'hashed_pw2', 'anna92@example.com', 'Nagy Anna', '+36301239876', 'customer', '2025-11-11 10:10:05'),
(3, 'admin', 'hashed_admin', 'admin@pizzaparadise.hu', 'Rendszergazda', '+3612345678', 'admin', '2025-11-11 10:10:05'),
(4, 'tomi_futár', 'hashed_pw3', 'tomi@pizzaparadise.hu', 'Tóth Tamás', '+36203334455', 'courier', '2025-11-11 10:10:05');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `allergens`
--
ALTER TABLE `allergens`
  ADD PRIMARY KEY (`allergen_id`);

--
-- A tábla indexei `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `cart_id` (`cart_id`);

--
-- A tábla indexei `orders_item`
--
ALTER TABLE `orders_item`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `topping_id` (`topping_id`);

--
-- A tábla indexei `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `order_id` (`order_id`);

--
-- A tábla indexei `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `type_id` (`type_id`);

--
-- A tábla indexei `product_allergens`
--
ALTER TABLE `product_allergens`
  ADD PRIMARY KEY (`product_id`,`allergen_id`),
  ADD KEY `allergen_id` (`allergen_id`);

--
-- A tábla indexei `product_toppings`
--
ALTER TABLE `product_toppings`
  ADD PRIMARY KEY (`product_id`,`topping_id`),
  ADD KEY `topping_id` (`topping_id`);

--
-- A tábla indexei `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `shopping_cart_items`
--
ALTER TABLE `shopping_cart_items`
  ADD PRIMARY KEY (`cart_item_id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `topping_id` (`topping_id`);

--
-- A tábla indexei `toppings`
--
ALTER TABLE `toppings`
  ADD PRIMARY KEY (`topping_id`);

--
-- A tábla indexei `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`type_id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `addresses`
--
ALTER TABLE `addresses`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `allergens`
--
ALTER TABLE `allergens`
  MODIFY `allergen_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `orders_item`
--
ALTER TABLE `orders_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `shopping_cart`
--
ALTER TABLE `shopping_cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `shopping_cart_items`
--
ALTER TABLE `shopping_cart_items`
  MODIFY `cart_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `toppings`
--
ALTER TABLE `toppings`
  MODIFY `topping_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `type`
--
ALTER TABLE `type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`cart_id`) REFERENCES `shopping_cart` (`cart_id`);

--
-- Megkötések a táblához `orders_item`
--
ALTER TABLE `orders_item`
  ADD CONSTRAINT `orders_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `orders_item_ibfk_3` FOREIGN KEY (`topping_id`) REFERENCES `toppings` (`topping_id`);

--
-- Megkötések a táblához `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `type` (`type_id`);

--
-- Megkötések a táblához `product_allergens`
--
ALTER TABLE `product_allergens`
  ADD CONSTRAINT `product_allergens_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_allergens_ibfk_2` FOREIGN KEY (`allergen_id`) REFERENCES `allergens` (`allergen_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `product_toppings`
--
ALTER TABLE `product_toppings`
  ADD CONSTRAINT `product_toppings_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_toppings_ibfk_2` FOREIGN KEY (`topping_id`) REFERENCES `toppings` (`topping_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD CONSTRAINT `shopping_cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `shopping_cart_items`
--
ALTER TABLE `shopping_cart_items`
  ADD CONSTRAINT `shopping_cart_items_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `shopping_cart` (`cart_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `shopping_cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `shopping_cart_items_ibfk_3` FOREIGN KEY (`topping_id`) REFERENCES `toppings` (`topping_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
