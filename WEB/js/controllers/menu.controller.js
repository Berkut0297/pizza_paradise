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

              //A vissza adott adatok mentése a toppings változóba
              $scope.toppings = responze;

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
      //gettopings függvény meghivása
      $scope.gettoppings();

      //buypizza függvény definiálása
      $scope.buypizza = function (pizzas) {

          //minden megnyitaskor 1-re alitja a mennyiseget
          $scope.quantity = 1;

          //minden megnyitaskor le nullaza a plusz feltétek számát
          $scope.toppingsc = 0;

          //pizzas változó értékének  másolása a pizzasModal változóba
          $scope.pizzasModal = angular.copy(pizzas);

          //total valtozoba mentjuk az adott pizza egység árját
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
        //le ellenőrizzük a kiválasztott  feltétek számát 
        if ($scope.toppingsc < 3) {

          

          //ellenőrzzük hogy az elem ki lett e választva
          //ha kilett választva
          if (item.selected){

                //ha igen megnöveljük a teljes összeget
                $scope.total += parseInt(item.price);
                console.log($scope.toppingsc);

                //megnöveljuk 1 el a feltétel számlálót
                $scope.toppingsc++;
          }

          //ha nem lett kiválasztva
          else{
            //ha az elem kiválasztását megszünteti a felhasználó,
            //kivonjuk a feltét árát
            $scope.total -= parseInt(item.price);

            //csökkentjuk 1-el a feltét számlálót
            $scope.toppingsc--;
            console.log($scope.toppingsc ,"fsa");
          } 

          //Async függvény meghivása
          $scope.$applyAsync();
        }

        //ha a felhasználó értesitése ha elérte a maximum plusz feltét számát
        else {
          alert("Maximum 3 extra feltétet lehet kiválasztani!");

          //az éppen kiválasztott de a mennyiséget tullépet elemet 
          // kiválasztását false-ra változtatjuk
          item.selected = false;
        }
        
      };

    }
  ]);

})(window, angular);
