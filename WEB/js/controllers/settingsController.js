;(function(window, angular) {
  'use strict'; 
  //Angulár modul meghivása 
  angular.module('app')

  //Controller létrehozása 'settingsController' néven
  .controller('settingsController', [

    //$scope betöltése a controllerbe
    '$scope',
    'http',

    //függvény definiálása
    function($scope,http) {
      console.log($scope.updateUser)
      $scope.userDataUpdate = function(){
          http.request({

          url: './php/settings.php',

          data: $scope.updateUser

        })
        .then(responze => {
          if (responze.affectedRow) {
            alert("A változtatás sikeres")
          }
        })
        .catch(e => console.log(e));
      }
    }
  ]);
})(window, angular);
