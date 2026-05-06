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
      console.log("sddfs")
        http.request({

        url: './php/cart.php',

        data: {user_id : $rootScope.user[0].user_id}

      })
      .then(responze => {
        $scope.cartItems = responze 
        console.log($scope.cartItems)
      })
      .catch(e => console.log(e));
            console.log($scope.cartItems)

      }
  ]);
})(window, angular);
