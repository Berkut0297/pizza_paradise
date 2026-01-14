;(function(window, angular) {
  'use strict'; 
  //Angulár modul meghivása 
  angular.module('app')
  //Controller létrehozása 'homeController' néven
  .controller('homeController', [
    //$scope betöltése a controllerbe
    '$scope',
    //függvény definiálása
    function($scope) {
      console.log('Home controller...');
    }
  ]);
})(window, angular);
