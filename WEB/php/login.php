<?php
require_once("../../../common/php/environment.php");

$args = Util::getArgs();

$db = new Database();

$query =" SELECT `user_id`, `full_name`, `password`, `email` 
          FROM `users` 
          WHERE `email` = `email` 
          LIMIT 1;";

$result = $db->execute($query);

if ($result[0]["email"] !=$args["email"])
    Util::setError("Nincs ilyen email cím regisztrálva!");

if ($result[0]["password"] != $args["password"])
    Util::setError("A jelszó nem helyes!");

Util::setResponse($result);

$db = null;

?>