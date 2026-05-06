;(function(window, angular) {
  'use strict'; 
  //Angulár modul meghivása 
  angular.module('app')

  //Controller létrehozása 'cartController' néven
  .controller('cartController', [

    //$scope betöltése a controllerbe
    '$scope',
    'http',
    '$rootScope',

    //függvény definiálása
    function($scope,http,$rootScope) {
      $scope.totalprice = 0
        http.request({
          url: './php/cart.php',
          data: {user_id : $rootScope.user[0].user_id}

      })
      .then(responze => {
        $scope.cartItems = responze
        console.log(responze)
        $scope.$applyAsync();
        if ($scope.cartItems.length) {
          for (let i = 0; i < responze.length; i++) {
          $scope.totalprice += responze[i].price
          console.log("alma")
        }
        }
        
      })
      .catch(e => console.log(e));

      $scope.removeFromCart = function (item) {
        http.request({
          url: './php/removeFromCart.php',
          data: {user_id : $rootScope.user[0].user_id,
                 cart_id : item}
        })
        .then(responze => {
          $scope.cartItems = responze
          $scope.$applyAsync();
          for (let i = 0; i < responze.length; i++) {
            $scope.totalprice += responze[i].price
          }
        })
        .catch(e => console.log(e));
      }


      }
  ]);
})(window, angular);
