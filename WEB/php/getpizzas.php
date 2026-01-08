<?php
require_once("../../../common/php/environment.php");
$db = new Database();
$query = "SELECT `name`,
                 `description`,
                 `price`,
                 `type_id`,
                 `image_url`,
                 `available`
          FROM   `products`
          WHERE  `type_id` = 1;";
$result = $db->execute($query);

$db = null;

Util::setResponse($result);