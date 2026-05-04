<?php
//enviroment.php betöltése 
require_once("../../../common/php/environment.php");

//argumentum definiálása
$args = Util::getArgs();


//adatbázisra kacsolás
$db = new Database();

//sql parancs definiálása
$query =" SELECT  `user_id`,
                  `username`,
                  `email`,
                  `full_name`,
                  `Gender`,
                  `phone`,
                  `role`
          FROM `users` 
          WHERE `email` = :email AND 
                `password` = :password
          LIMIT 1;";

//sql parancs végrehajtása
$result = $db->execute($query, ["email" => $args["email"],
                                "password" => $args["password"]]);

//adatbázis le kapcsolás
$db = null;

//email regisztrációjának ellenörzése
if ($result == null)

    //ha nincs regisztrálva ilyen email visszatérés hiba üzenettel
    Util::setError("Jelszó vagy az email cim nem helyes!");


//vissztérési értek megadása és vissza térés
Util::setResponse($result);


?>