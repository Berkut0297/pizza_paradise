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

          //pizzas változó értékének  másolása a pizzasModal változóba
          $scope.pizzasModal = angular.copy(pizzas);
          $scope.total = parseInt($scope.pizzasModal.price);

          //modal nevezetű váltózó létrehozása boostrap modal megjelenítéséhez
          // let modal = new bootstrap.Modal(

          //   //pizzaModal id-jú elem megkeresése a html-ben
          //   document.getElementById('pizzaModalbuy')
          // );

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


          //Bootstrap modal megjelenítése
          // modal.show();
      }
      //teljes összeg kiszamitas függvény
      $scope.getTotalPrice = function(pizzasModal) {
        console.log(pizzasModal);

        //extras valtozoba elmentjuk a toppings tömb elemeit
        let extras = Object.values($scope.topprices || {})
                //eltavolitjuk a nem kivalasztott elemeket
                .filter((t) => t.selected === true)
                //összegezzük a kivalasztott elemek értéket
                .reduce((sum, t) => sum + t.price, 0);
        //visszaterünk a pizza ara + az elöbb összesitett feltétek összegével
        //majd megszorozzuk a mennyiséggel
        console.log(extras);
        return (pizzasModal + extras) * $scope.quantity;
      };

      $scope.adam = (item) => {
        let a = parseInt(item.price);
        if (item.selected)
              $scope.total += parseInt(item.price);
        else  $scope.total -= parseInt(item.price);
        $scope.$applyAsync();
        console.log(item);
      };

    }
  ]);

})(window, angular);
