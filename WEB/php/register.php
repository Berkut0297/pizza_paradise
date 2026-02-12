<?php
//enviroment.php betöltése 
require_once("../../../common/php/environment.php");

//argumentum definiálása
$args = Util::getArgs();

//adatbázisra kacsolás
$db = new Database();

//sql parancs definiálása
$query = "SELECT user_id FROM users WHERE email = ? OR phone = ?";

//sql parancs végrehajtása
$result = $db->execute($query, [ $args['email'], $args['phone'] ]);

//erredmény ellenörzése egyezés eseten visszatér a felhasználonak hibaval
if (!empty($result)) {
    Util::setError("Az email vagy telefonszám már használatban van!");
}
//preparateInsert segéd fügvény segitségével le generáljuk az insert sql parancsot
$query = $db->preparateInsert("users",$args);

//végre hajtjuk az elöbb legenerált insert parancsot
$result = $db->execute($query, array_values($args));

//adatbázis le kapcsolás
$db = null;

//vissztérési értek megadása és vissza térés
Util::setResponse($result);
