;(function(window, angular) {
  'use strict'; 
  //Angulár modul meghivása 
  angular.module('app')

  //Controller létrehozása 'headerController' néven
  .controller('headerController', [

    //$scope betöltése a controllerbe
    '$scope',
    '$state',
    '$rootScope',

    //függvény definiálása
    function($scope, $state, $rootScope) {

      //logout függvény definiálása
      $scope.logOut = function () {

          //a localstorage-ben lévő adatok eltavolitasa
          localStorage.removeItem('user');
          $rootScope.user = null;
          //kijelentkezes utan át iranyit a fő oldalra
          $state.go('home');
          $scope.canBuy = false;
      }
    }
  ]);
})(window, angular);
