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

      //showModal függvény definiálása
      $scope.showModal = function (pizzas) {

          //pizzas változó értékének  másolása a pizzasModal változóba
          $scope.pizzasModal = angular.copy(pizzas);

          //modal nevezetű váltózó létrehozása boostrap modal megjelenítéséhez
          let modal = new bootstrap.Modal(

            //pizzaModal id-jú elem megkeresése a html-ben
            document.getElementById('pizzaModal')
          );
       
          //Bootstrap modal megjelenítése
          modal.show();
      }
    }
  ]);

})(window, angular);
