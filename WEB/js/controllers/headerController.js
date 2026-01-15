;(function(window, angular) {
  'use strict'; 
  //Angulár modul meghivása 
  angular.module('app')

  //Controller létrehozása 'headerController' néven
  .controller('headerController', [

    //$scope betöltése a controllerbe
    '$scope',
    '$state',

    //függvény definiálása
    function($scope, $state) {

      //logout függvény definiálása
      $scope.logOut = function () {

          //a localstorage-ben lévő adatok eltavolitasa
          localStorage.removeItem('user');
          
          //kijelentkezes utan át iranyit a fő oldalra
          $state.go('home');
      }
    }
  ]);
})(window, angular);
