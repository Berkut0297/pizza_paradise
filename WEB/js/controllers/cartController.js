;(function(window, angular) {
  'use strict'; 
  //Angulár modul meghivása 
  angular.module('app')

  //Controller létrehozása 'cartController' néven
  .controller('cartController', [

    //$scope betöltése a controllerbe
    '$scope',
    'http',

    //függvény definiálása
    function($scope,http) {
      $scope.userDataUpdate = function(){
        http.request({

        url: './php/cart.php',

        data: user_pizzaParadise[0].user_id

      })
      .then(responze => {
        cartItems = responze 
      })
      .catch(e => console.log(e));
      }
    }
  ]);
})(window, angular);
