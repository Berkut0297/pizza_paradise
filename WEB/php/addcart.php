  <?php
  //enviroment.php betöltése
  require_once("../../../common/php/environment.php");

  //adatbázisra kacsolás
  $db = new Database();

  $args = Util::getArgs();

  $query ="SELECT `cart_id`
          FROM `shopping_cart` 
          WHERE `user_id` = :user_id;";

  //sql helper fugbény hivása
  $result = $db->execute($args,["user_id" => $args["user_id"]]);

  if (count($result) == 0) {

    //sql parancs definiálása
    $query = "INSERT INTO `shopping_cart`(`user_id`) VALUES (:user_id);";

    //sql parancs végrehajtása
    $result = $db->execute($query, ["user_id" => $args["user_id"]]);
  }

  $query = "INSERT INTO `shopping_cart_items`(`cart_id`, `product_id`, `quantity`) 
            VALUES (:cart_id, :product_id, :quantity);";

  //sql parancs végrehajtása
  $result = $db->execute($query, ["cart_id" => $result["cart_id"],
                                "product_id" => $args["product_id"], 
                                "quantity" => $args["quantity"]]);

  //adatbázis le kapcsolás
  $db = null;

  //vissztérési értek megadása és vissza térés
  Util::setResponse($result);