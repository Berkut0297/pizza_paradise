<?php
//Load the enviroment.php
require_once("../../../common/php/environment.php");
//argument define
$args = Util::getArgs();
//db connection
$db = new Database();
//define the sql command
$query =" SELECT `user_id`, `full_name`, `password`, `email` 
          FROM `users` 
          WHERE `email` = `email` 
          LIMIT 1;";
//execute the sql command
$result = $db->execute($query);
// check the registration of the email and the password
if ($result[0]["email"] !=$args["email"])
    Util::setError("Nincs ilyen email cím regisztrálva!");

if ($result[0]["password"] != $args["password"])
    Util::setError("A jelszó nem helyes!");
//set the response
Util::setResponse($result);
//close the connection
$db = null;

?>