<?php
//enviroment.php betöltése
require_once("../../../common/php/environment.php");
require_once("./php/getdata.php");


//adatbázisra kacsolás
$db = new Database();

//argumentum definiálása
$args = Util::getArgs();

//sql command definiálása
$query = "DELETE
          FROM `shopping_cart_items`
          WHERE `cart_id` = :cart_id;";

//sql parancs végrehajtása
$result = $db->execute($query, ["cart_id" => $args["cart_id"]]);

//parancs sikeres végrehajtásának ellenörzése
if (!$result["affectedRows"]) {
  $db = null;
  Util::setError('A törlés sikertelen!');
}


//sql helper fugbény hivása sikeres törlés esetén
$result = getCart($db,["user_id" => $args["user_id"]]);

//adatbázis le kapcsolás
$db = null;

//vissztérési értek megadása és vissza térés
Util::setResponse($result);