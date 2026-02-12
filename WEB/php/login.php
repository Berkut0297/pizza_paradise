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
                  `password`,
                  `email`,
                  `full_name`,
                  `Gender`,
                  `phone`,
                  `role`
          FROM `users` 
          WHERE `email` = :email
          LIMIT 1;";

//sql parancs végrehajtása
$result = $db->execute($query, ["email" => $args["email"]]);

//adatbázis le kapcsolás
$db = null;

//email regisztrációjának ellenörzése
if ($result == null)

    //ha nincs regisztrálva ilyen email visszatérés hiba üzenettel
    Util::setError("Nincs ilyen email cím regisztrálva!");

//jelszó helyességének ellenörzése
if ($result[0]["password"] != $args["password"])

    //ha nem helyes a jelszó visszatérés hiba üzenettel
    Util::setError("A jelszó nem helyes!");

//vissztérési értek megadása és vissza térés
Util::setResponse($result);


?>