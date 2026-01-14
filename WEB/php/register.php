<?php
//enviroment.php betöltése 
require_once("../../../common/php/environment.php");

//argumentum definiálása
$args = Util::getArgs();

//adatbázisra kacsolás
$db = new Database();

//sql parancs definiálása
$query = "SELECT `email`,`phone` FROM users;";

//sql parancs végrehajtása
$result = $db->execute($query);

//adatbázis le kapcsolás
$db = null;

//email ellenörzése hogy regisztráva van e már
if (isset($result[0]["email"]) && $result[0]["email"] === $args["email"])

  //ha már regisztrálva van ilyen email visszatérés hiba üzenettel 
  Util::setError("Az email már használt!");

//telefonszám ellenözése hogy regisztráva van e már
if (isset($result[0]["phone"]) && $result[0]["phone"] === $args["phone"]) 

  //ha már regisztrálva van ilyen telefonszám visszatérés hiba üzenettel 
  Util::setError("A Telefon szám már használt!");

//preparateInsert segéd fügvény segitségével le generáljuk az insert sql parancsot
$query = $db->preparateInsert("users",$args);

//végre hajtjuk az elöbb legenerált insert parancsot
$result = $db->execute($query, array_values($args));

//vissztérési értek megadása és vissza térés
Util::setresponse($result);
