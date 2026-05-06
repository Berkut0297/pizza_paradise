<?php
//enviroment.php betöltése
require_once("../../../common/php/environment.php");
require_once("./php/getdata.php");


//adatbázisra kacsolás
$db = new Database();

$args = Util::getArgs();



//sql helper fugbény hivása
$result = getCart($db,$args);

//adatbázis le kapcsolás
$db = null;

//vissztérési értek megadása és vissza térés
Util::setResponse($result);