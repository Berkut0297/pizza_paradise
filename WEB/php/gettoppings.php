<?php
//enviroment.php betöltése 
require_once("../../../common/php/environment.php");

//adatbázisra kacsolás
$db = new Database();

//sql parancs definiálása
$query = "SELECT `name`,
                 `price`,
                 `type_id`,
                 `available`
          FROM   `products`
          WHERE  `type_id` = 2;";

//sql parancs végrehajtása      
$result = $db->execute($query);

//adatbázis le kapcsolás
$db = null;

//vissztérési értek megadása és vissza térés
Util::setResponse($result);