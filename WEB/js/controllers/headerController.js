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
      $scope.logOut = function () {
          localStorage.removeItem('user');
          $state.go('home');
          console.log('Logout...');
      }
    }
  ]);
})(window, angular);
