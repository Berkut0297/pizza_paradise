  ; (function (window, angular) {
    'use strict';
    //Angulár modul meghivása
    angular.module('app')

      //Controller létrehozása 'registerController' néven
    .controller('registerController', [

      //elemek betöltése a controllerbe
      '$scope',
      'http',
      '$state',
      'util',

      //függvény definiálása a betöltött elemekkel
      function ($scope, http, $state, util) {

        //registerButton függvény definiálása
        $scope.registerButton = function () {

          //data nevű objektum létrehozása aminek értékét a modelben átadott adatokkal feltöltjük
          //objFilterByKeys függvény meghivása
          let data = util.objFilterByKeys(

            //a felhasználó adataival feltöltött objektum
            $scope.model,

            //megadjuk a függvénynek mely adatotkat filterelje el az objektumból
            'confirmPassword;showPassword,showConfirmPassword',

            //a false érték megadásával megadjuk hogy ezen kulcs érték párosokat távoltja el az objektumból
            false
          );

          //http kérelem 
          http.request({
            method: 'POST',

            //php fájl útvonala
            url: './php/register.php',

            //küldendő adat megadása a fentebb filterezett data objektummal
            data: data
          })
          //Visszaadott adatok kezelése
          .then(response => {

            //A vissza adott adatok mentése a isRegistered változóba
            $scope.isRegistered = response;

            //Visszaa jelzés a felhasználónak sikeres regisztráció estén 
            $scope.Message = "Sikeres regisztráció";

            //Async függvény meghivása
            $scope.$applyAsync();

            //át iránytás a login statre(oldalra)
            $state.go('login')
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
