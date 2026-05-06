<?php
declare(strict_types=1);

// Get books
function getCart(Database $db, array $args): ?array {

  // Set query
  $query = "SELECT  users.full_name,
                  shopping_cart.cart_id,
                  shopping_cart_items.product_id,
                  products.name,
                  products.price,               
                  shopping_cart_items.quantity,
                  (products.price * shopping_cart_items.quantity) AS total
            FROM shopping_cart_items
            JOIN products
                ON shopping_cart_items.product_id = products.product_id

            JOIN shopping_cart
                ON shopping_cart_items.cart_id = shopping_cart.cart_id

            JOIN users
                ON shopping_cart.user_id = users.user_id

            WHERE users.user_id = :user_id";

  return $db->execute($query,$args);
}