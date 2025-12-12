<?php
session_start();
require_once("../../../common/php/environment.php");

// POST data decodeolása
$data = json_decode(file_get_contents("php://input"), true);

// Input validálása
if (!isset($data['email']) || !isset($data['password'])) {
    echo json_encode(array("error" => "Hiányzik az email vagy jelszó!"));
    exit;
}

// Adatbázishoz való kapcsolat létrehozása
$db = new Database("pizzaparadise");

// SQL parancs megadása
$query = "SELECT `id`, `name`, `admin`, `address` FROM `users` WHERE `email` = ? AND `password` = ?";

// Paraméterekkel a query végrehajtása
$result = $db->execute($query, [$data['email'], $data['password']]);

//Ha jó a result, session superglobal-ba eltárolja a felhasználó adatait 
//Ha nem, akkor error-t küld vissza
if ($result) {
    $_SESSION['user_id'] = $result[0]['id'];
    $_SESSION['user_name'] = $result[0]['name'];
    $_SESSION['is_admin'] = $result[0]['admin'];
    $_SESSION['user_email'] = $data['email'];
    $_SESSION['user_address'] = $result[0]['address'];
    
    echo json_encode(array(
        "result" => "success"
    ));
} else {
    echo json_encode(array("error" => "Hibás az email vagy jelszó!"));
}

$db = null;