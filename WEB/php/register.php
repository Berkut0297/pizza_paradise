<?php
//Load the enviroment.php
require_once("../../../common/php/environment.php");

//argument define
$args = Util::getArgs();

//db connection
$db = new Database();

//define the sql command
$query = "SELECT `email`,`phone` FROM users;";

//execute the sql command
$result = $db->execute($query);

//close the connection
$db = null;

//check the email is already in the database
if (isset($result[0]["email"]) && $result[0]["email"] === $args["email"]) 
  Util::setError("Az email már használt!");

//check the phone is already in the database
if (isset($result[0]["phone"]) && $result[0]["phone"] === $args["phone"]) 
  Util::setError("A Telefon szám már használt!");

//prepare the insert
$query = $db->preparateInsert("users",$args);

//execute the insert to the data base
$result = $db->execute($query, array_values($args));

//set the response
Util::setresponse($result);
