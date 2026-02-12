;(function(window, angular) {
  'use strict'; 
  //Angulár modul meghivása 
  angular.module('app')

  //Controller létrehozása 'settingsController' néven
  .controller('settingsController', [

    //$scope betöltése a controllerbe
    '$scope',

    //függvény definiálása
    function($scope) {
      console.log('Shopeng cart controller...');
    }
  ]);
})(window, angular);
