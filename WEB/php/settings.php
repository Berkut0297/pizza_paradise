<?php
//enviroment.php betöltése 
require_once("../../../common/php/environment.php");

$args = Util::getArgs();  

//adatbázisra kacsolás
$db = new Database();

//sql parancs definiálása
$query =$db-> preparateUpdate("users",array_keys($args),"user_id");
$query .= " WHERE user_id = :user_id";
//sql parancs végrehajtása      
$result = $db->execute($query, $args);
//parancs sikeres végrehajtásának ellenörzése
if (!$result["affectedRows"]) {
  $db = null;
  Util::setError('A modosítás  sikertelen!');
}
//adatbázis le kapcsolás
$query =" SELECT  `user_id`,
                  `username`,
                  `email`,
                  `full_name`,
                  `Gender`,
                  `phone`,
                  `role`
          FROM `users` 
          WHERE `user_id` = :user_id
          LIMIT 1;";

//sql parancs végrehajtása
$result = $db->execute($query, ["user_id" => $args["user_id"]]);

//adatbázis le kapcsolás
$db = null;

//vissztérési értek megadása és vissza térés
Util::setResponse($result);