<?php
//enviroment.php betöltése 
require_once("../../../common/php/environment.php");

$args = Util::getArgs();  

//adatbázisra kacsolás
$db = new Database();

//sql parancs definiálása
$query = preparateUpdate("users",$args);

//sql parancs végrehajtása      
$result = $db->execute($query);

//adatbázis le kapcsolás
$db = null;

//vissztérési értek megadása és vissza térés
Util::setResponse($result);