-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Jan 30. 08:28
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
(4, 4, 'Pécs', 'Rákóczi út', '7621', '2A'),
(5, 5, 'Debrecen', 'Piac utca', '4025', '22'),
(6, 5, 'Budapest', 'Fő utca', '1011', '14B'),
(7, 6, 'Győr', 'Baross Gábor út', '9022', '7'),
(8, 7, 'Miskolc', 'Szent István tér', '3525', '10'),
(9, 8, 'Budapest', 'Váci út', '1132', '31'),
(10, 9, 'Szolnok', 'Ady Endre út', '5000', '2'),
(11, 10, 'Pécs', 'Jókai tér', '7621', '8'),
(12, 13, 'Eger', 'Dobó tér', '3300', '3'),
(13, 14, 'Tatabánya', 'Ságvári út', '2800', '15A'),
(14, 6, 'Sopron', 'Tűztorony tér', '9400', '5');

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
(3, 'Hal', 'Hal és halmaradványt tartalmaz');

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
(2, 2, 2, 2, '2025-11-06 12:45:00', 'in_progress', 3240.00, 'cash'),
(3, 5, 5, 3, '2025-11-08 18:20:00', 'delivered', 5590.00, 'online'),
(4, 6, 7, 4, '2025-11-08 19:10:00', 'in_progress', 2990.00, 'cash'),
(5, 7, 8, 5, '2025-11-09 12:40:00', 'pending', 3290.00, 'card'),
(6, 8, 9, 6, '2025-11-09 15:30:00', 'delivered', 1980.00, 'cash'),
(7, 9, 10, 7, '2025-11-10 14:20:00', 'delivered', 2790.00, 'online'),
(8, 10, 11, 8, '2025-11-10 17:05:00', 'in_progress', 3490.00, 'cash'),
(9, 13, 12, 9, '2025-11-10 20:50:00', 'cancelled', 1650.00, 'card'),
(10, 14, 13, 10, '2025-11-11 09:10:00', 'pending', 2290.00, 'card');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders_item`
--

CREATE TABLE `orders_item` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `unit_price` int(5) NOT NULL,
  `subtotal` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `orders_item`
--

INSERT INTO `orders_item` (`order_item_id`, `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`) VALUES
(1, 1, 3, 1, 0, 2990),
(2, 1, 6, 2, 0, 1100),
(3, 2, 4, 1, 0, 2690),
(4, 2, 7, 1, 0, 550),
(5, 3, 1, 2, 0, 4580),
(6, 3, 9, 1, 0, 750),
(7, 4, 3, 1, 0, 3140),
(8, 5, 5, 1, 0, 3290),
(9, 6, 8, 2, 0, 1980),
(10, 7, 2, 1, 0, 2990),
(11, 8, 4, 1, 0, 2890),
(12, 8, 6, 1, 0, 550),
(13, 9, 6, 3, 0, 1650),
(14, 10, 1, 1, 0, 2290);

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
(2, 2, '2025-11-06 12:50:00', 3240.00, 'pending'),
(3, 3, '2025-11-08 18:25:00', 5590.00, 'completed'),
(4, 4, '2025-11-08 19:12:00', 2990.00, 'pending'),
(5, 5, '2025-11-09 12:41:00', 3290.00, 'completed'),
(6, 6, '2025-11-09 15:35:00', 1980.00, 'completed'),
(7, 7, '2025-11-10 14:25:00', 2790.00, 'completed'),
(8, 8, '2025-11-10 17:06:00', 3490.00, 'pending'),
(9, 9, '2025-11-10 20:51:00', 1650.00, 'failed'),
(10, 10, '2025-11-11 09:11:00', 2290.00, 'pending');

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
(1, 'Margherita', 'Olasz paradicsom, mozzarella sajt, grana padano (parmezán) sajt szórás', 2890.00, 1, 'margherita.png', 1),
(2, 'Sonka Gomba oliva', 'Olasz paradicsom, mozzarella sajt, olasz főtt sonka, gomba, olivabogyó, grana padano (parmezán) sajt szórás.', 3390.00, 1, 'sonka_gomba_oliva.png', 1),
(3, 'Olasz Bacon', 'Olasz paradicsom, mozzarella sajt, guanciale(szalonna), szarvasgombás olivaolaj, paradicsomos pesto, grana padano (parmezán) sajt szórás.', 3590.00, 1, 'olasz_bacon.png', 1),
(4, 'Nápolyi Szalámi', 'Olasz paradicsom, mozzarella sajt, nápolyi szalámi, articsóka, grana padano (parmezán) sajt szórás', 3590.00, 1, 'napolyi_szalami.png', 1),
(5, 'Olasz Kolbászos', 'Olasz paradicsom, mozzarella sajt, spianata (olasz kolbász, enyhén csípős), grana padano (parmezán) sajt szórás', 3590.00, 1, 'olasz_kolbaszos.png', 1),
(6, '4 Sajtos', 'Olasz paradicsom, mozzarella, gouda, gorgonzola sajtok és grana padano (parmezán) sajt szórás.', 3590.00, 1, '4_sajtos.png', 1),
(7, 'Császár Pizza\n', 'Olasz paradicsom, mozzarella sajt, pancetta(olasz császárszalonna), koktélparadicsom, lilahagyma, grana padano(parmesan) sajt szórás.', 3690.00, 1, 'csaszar.jpg', 1),
(8, 'Nápolyi Bambino', 'Olasz paradicsom, mozzarella sajt, olasz főtt sonka, kukorica, grana padano (parmezán) sajt szórás.', 3390.00, 1, 'bambino.png', 1),
(9, 'Nápolyi Rukkola', 'Olasz paradicsom, mozzarella sajt, rukkola saláta, koktélparadicsom, fekete erdei sonka, grana padano (parmezán) sajt szórás.\n', 3690.00, 1, 'rukkola.jpg', 1),
(10, 'Nápolyi Tonhal', 'Olasz paradicsom, mozzarella sajt, tonhal darabok, olivabogyó, lilahagyma, grana padano (parmezán) sajt szórás.', 3990.00, 1, 'tonhal.jpg', 1),
(11, 'Plusz Sajt', NULL, 400.00, 2, NULL, 1),
(12, 'Bacon', NULL, 500.00, 2, NULL, 1),
(13, 'Olasz Sonka', NULL, 500.00, 2, NULL, 1),
(14, 'Olasz Kolbász', NULL, 500.00, 2, NULL, 1),
(15, 'Nápolyi Szalámi', NULL, 500.00, 2, NULL, 1),
(16, 'Fekete Erdei Sonka', NULL, 500.00, 2, NULL, 1),
(17, 'Peperóni Szalámi', NULL, 500.00, 2, NULL, 1),
(18, 'Pancetta Fűszeres Császárszalonna', NULL, 600.00, 2, NULL, 1),
(19, 'Gombakrém', NULL, 500.00, 2, NULL, 1),
(20, 'BBQ Gomba mix', NULL, 500.00, 2, NULL, 1),
(21, 'Olivabogyó', NULL, 400.00, 2, NULL, 1),
(22, 'Koktélparadicsom', NULL, 300.00, 2, NULL, 1),
(23, 'Articsóka', NULL, 400.00, 2, NULL, 1),
(24, 'kukorica', NULL, 300.00, 2, NULL, 1),
(25, 'Póréhagyma', NULL, 300.00, 2, NULL, 1),
(26, 'Lilahagyma', NULL, 300.00, 2, NULL, 1),
(27, 'Jalapeno Paprika Szeletek', NULL, 400.00, 2, NULL, 1),
(28, 'Ananász', NULL, 400.00, 2, NULL, 1),
(29, 'Nápolyi Pepperoni szalámi', 'Olasz paradicsom, mozzarella sajt, pepperoni szalámi, grana padano (parmezán) sajt szórás', 3390.00, 1, 'pepperoni_n.jpg', 1);

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
(6, 1),
(6, 2),
(7, 1),
(7, 2),
(8, 1),
(8, 2),
(9, 1),
(9, 2),
(10, 1),
(10, 2),
(10, 3);

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
(5, 8),
(10, 6),
(10, 8),
(12, 5);

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
(2, 2, '2025-11-11 10:10:05'),
(3, 5, '2025-12-09 07:49:48'),
(4, 6, '2025-12-09 07:49:48'),
(5, 7, '2025-12-09 07:49:48'),
(6, 8, '2025-12-09 07:49:48'),
(7, 9, '2025-12-09 07:49:48'),
(8, 10, '2025-12-09 07:49:48'),
(9, 13, '2025-12-09 07:49:48'),
(10, 14, '2025-12-09 07:49:48');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `shopping_cart_items`
--

CREATE TABLE `shopping_cart_items` (
  `cart_item_id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `shopping_cart_items`
--

INSERT INTO `shopping_cart_items` (`cart_item_id`, `cart_id`, `product_id`, `quantity`) VALUES
(1, 1, 3, 1),
(2, 1, 6, 2),
(3, 2, 4, 1),
(4, 3, 1, 2),
(5, 3, 9, 1),
(6, 4, 3, 1),
(7, 5, 5, 1),
(8, 6, 8, 2),
(9, 7, 2, 1),
(10, 8, 4, 1),
(11, 9, 6, 3),
(12, 10, 1, 1);

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
(2, 'Feltét'),
(3, 'Kiegészítő');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `Gender` varchar(1) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role` enum('customer','admin','courier') DEFAULT 'customer',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `email`, `full_name`, `Gender`, `phone`, `role`, `created_at`) VALUES
(1, 'peter88', 'Peter1234', 'peter88@example.com', 'Kovács Péter', 'M', '+36201234567', 'customer', '2025-11-11 10:10:05'),
(2, 'anna92', 'Anna1234', 'anna92@example.com', 'Nagy Anna', 'F', '+36301239876', 'customer', '2025-11-11 10:10:05'),
(3, 'admin', 'Admin1234', 'admin@example.com', 'Rendszergazda', 'M', '+3612345678', 'admin', '2025-11-11 10:10:05'),
(4, 'tomi_futár', 'Tomifutar1234', 'tomi@pizzaparadise.hu', 'Tóth Tamás', 'M', '+36203334455', 'courier', '2025-11-11 10:10:05'),
(5, 'kati07', 'Kati1234', 'kati07@example.com', 'Farkas Katalin', 'F', '+36204443322', 'customer', '2025-12-09 07:49:16'),
(6, 'bence_dev', 'Bence1234', 'bence.dev@example.com', 'Török Bence', 'M', '+36304445566', 'customer', '2025-12-09 07:49:16'),
(7, 'zsombi12', 'Zsombi1234', 'zsombi12@example.com', 'Szabó Zsombor', 'M', '+36205556677', 'customer', '2025-12-09 07:49:16'),
(8, 'edit_nagy', 'Edit1234', 'edit.nagy@example.com', 'Nagy Edit', 'F', '+36207778899', 'customer', '2025-12-09 07:49:16'),
(9, 'rita_cs', 'Rita1234', 'rita.cs@example.com', 'Csorba Rita', 'F', '+36309998877', 'customer', '2025-12-09 07:49:16'),
(10, 'lilla89', 'Lilla1234', 'lilla89@example.com', 'Jakab Lilla', 'F', '+36201112233', 'customer', '2025-12-09 07:49:16'),
(11, 'vendeghaz', 'Vendeg1234', 'haz.vend@example.com', 'Vendégház', 'M', '+36201239845', 'admin', '2025-12-09 07:49:16'),
(12, 'feri_futar2', 'Ferifurtar1234', 'feri2@pizzaparadise.hu', 'Kiss Ferenc', 'M', '+36203335544', 'courier', '2025-12-09 07:49:16'),
(13, 'dani88', 'Dani1234', 'dani88@example.com', 'Somogyi Dániel', 'M', '+36304442322', 'customer', '2025-12-09 07:49:16'),
(14, 'zita77', 'Zita1234', 'zita77@example.com', 'Kádár Zita', 'F', '+36208889933', 'customer', '2025-12-09 07:49:16');

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
  ADD KEY `product_id` (`product_id`);

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
  ADD KEY `product_id` (`product_id`);

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
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT a táblához `allergens`
--
ALTER TABLE `allergens`
  MODIFY `allergen_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `orders_item`
--
ALTER TABLE `orders_item`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT a táblához `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT a táblához `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
