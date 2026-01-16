; (function (window, angular) {
  'use strict';
  //Angulár modul meghivása 
  angular.module('app')

  //Controller létrehozása 'menuController' néven
  .controller('menuController', [

    //elemek betöltése a controllerbe
    '$scope',
    '$state',
    'http',

    //függvény definiálása a betöltött elemekkel
    function ($scope, $state, http) {

      //getpizzas függvény definiálása
      $scope.getpizzas = function (){

        //http kérés és php fálj útvanalának megadása
        http.request('./php/getpizzas.php')

            //Visszaadott adatok kezelése
            .then(responze=>{

              //A vissza adott adatok mentése a pizzas változóba
              $scope.pizzas = responze;

              //Async függvény meghivása
              $scope.$applyAsync();
            })

            //Hiba kezelése
            .catch(e => {

              //Hiba kód mentése az msg változóba
              $scope.msg = e;

              //Hiba kód megjelenitése a felhasználónak
              alert(e)
            })
      }
      //getpizzas függvény meghivása
      $scope.getpizzas();

      //gettoppings függvény definiálása
      $scope.gettoppings = function (){

        //http kérés és php fálj útvanalának megadása
        http.request('./php/gettoppings.php')

            //Visszaadott adatok kezelése
            .then(responze=>{

              //A vissza adott adatok mentése a pizzas változóba
              $scope.toppings = responze;
              $scope.topprices = responze[1];

              //Async függvény meghivása
              $scope.$applyAsync();
            })

            //Hiba kezelése
            .catch(e => {

              //Hiba kód mentése az msg változóba
              $scope.msg = e;

              //Hiba kód megjelenitése a felhasználónak
              alert(e)
            })
      }
      //getpizzas függvény meghivása
      $scope.gettoppings();

      //buypizza függvény definiálása
      $scope.buypizza = function (pizzas) {

          //minden megnyitaskor 1-re alitja a mennyiseget
          $scope.quantity = 1;
          $scope.toppingsc = 1;
          //pizzas változó értékének  másolása a pizzasModal változóba
          $scope.pizzasModal = angular.copy(pizzas);
          $scope.total = parseInt($scope.pizzasModal.price);

          //mennyiseg növeles függvény
          $scope.increaseQty = function () {
	          $scope.quantity++;
          };


          //mennyiseg csökkentése függvény
          $scope.decreaseQty = function () {
          	if ($scope.quantity > 1) {
          		$scope.quantity--;
          	}
          };
      }
      //teljes összeg kiszamitas függvény
      $scope.getTotalPrice = (item) => {
        if ($scope.toppingsc <= 3) {
          $scope.toppingsc++;
          let a = parseInt(item.price);
          if (item.selected)
                $scope.total += parseInt(item.price);
          else  $scope.total -= parseInt(item.price);
          $scope.$applyAsync();
          console.log(item);
        }
        else {
          alert("Maximum 3 extra feltétet lehet kiválasztani!");
          item.selected = false;
        }
        
      };

    }
  ]);

})(window, angular);
