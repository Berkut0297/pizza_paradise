<?php
//enviroment.php betöltése 
require_once("../../../common/php/environment.php");

//adatbázisra kacsolás
$db = new Database();

//sql parancs definiálása
$query = "SELECT  `users`.`full_name`,
	                `shopping_cart`.`cart_id`,
                  `shopping_cart_items`.`product_id`,
                  `products`.`name`,
                  `shopping_cart_items`.`quantity`
          FROM `shopping_cart_items`

          JOIN `products` 
          ON   `shopping_cart_items`.`product_id` = `products`.`product_id`

          JOIN `shopping_cart`
          ON    `shopping_cart_items`.`cart_id` = `shopping_cart`.`cart_id`

          JOIN  `users`
          ON    `shopping_cart`.`user_id` = `users`.`user_id`
          
          WHERE `users`.`user_id` = 2";

//sql parancs végrehajtása      
$result = $db->execute($query);

//adatbázis le kapcsolás
$db = null;

//vissztérési értek megadása és vissza térés
Util::setResponse($result);