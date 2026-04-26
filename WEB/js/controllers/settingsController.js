;(function(window, angular) {
  'use strict'; 
  //Angulár modul meghivása 
  angular.module('app')

  //Controller létrehozása 'settingsController' néven
  .controller('settingsController', [

    //$scope betöltése a controllerbe
    '$scope',
    'http',
    '$rootScope',
    '$state',

    //függvény definiálása
    function($scope,http,$rootScope,$state) {
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
      $scope.userProfiledelete = function(){
          http.request({

          url: './php/profiledelete.php',

          data: $rootScope.user.user_id

        })
        .then(responze => {
            alert("A törlés sikeres")
            $state.go('home')

        })
        .catch(e => alert.log(e));
      }
    }
  ]);
})(window, angular);
