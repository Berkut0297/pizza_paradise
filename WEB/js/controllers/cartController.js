;(function(window, angular) {
  'use strict'; 
  //Angulár modul meghivása 
  angular.module('app')

  //Controller létrehozása 'cartController' néven
  .controller('cartController', [

    //$scope betöltése a controllerbe
    '$scope',

    //függvény definiálása
    function($scope) {
      console.log('Shopeng cart controller...');
    }
  ]);
})(window, angular);
