; (function (window, angular) {
  'use strict';
  //Angulár modul meghivása
  angular.module('app')

    //Controller létrehozása 'loginController' néven
    .controller('loginController', [

      //elemek betöltése a controllerbe
      '$scope',
      '$rootScope',
      'http',
      '$state',

      //függvény definiálása a betöltött elemekkel
      function ($scope, $rootScope, http, $state) {

        //loginBtn fügvény definiálása
        $scope.loginBtn = function () {
          $scope.canBuy = false;
          //http kérelem
          http.request({

            //php fálj utvonala
            url: './php/login.php',

            //php fájbe küldött adatok betöltése
            data: {
              email: $scope.model.email,
              password: $scope.model.password
            }                  
          })
          //Visszaadott adatok kezelése
          .then(response => {

            //A vissza adott adatok mentése a user változóba
            $rootScope.user = response;
                        
            //Async függvény meghivása
            $scope.$applyAsync(); 

            //localsotorebe eltarojuk a vissza adott adatokat user néven
            localStorage.setItem('user', JSON.stringify(response));
            
            $state.go('home')

            $scope.canBuy = true;
          })

          //Hiba kezelése
          .catch(e => {

            //Hiba kód mentése az msg változóba
            $scope.msg = e;

            //Hiba kód megjelenitése a felhasználónak
            alert(e)
          })
        }
      }
    ])

})(window, angular);
