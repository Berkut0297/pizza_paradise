<?php
declare(strict_types=1);

// Include environment
require_once('../../common/php/environment.php');

$args = Util::getArgs();

$db = new Database(); 

// Set query
$query = "DELETE
          FROM `user`
          WHERE `user_id` = :user_id";

// Execute SQL command
$result = $db->execute($query, $args);

if (!$result["affectedRows"]) {
  $db = null;
  Util::setError('A törlés sikertelen!');
}
$result = getCountries($db);
$db = null;
// Set response
Util::setResponse($result);