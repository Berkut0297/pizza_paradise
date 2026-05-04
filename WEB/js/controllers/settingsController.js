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
      $scope.updateUser = {email: '',phone: '',password: ''};
      $scope.updateUser.email = $rootScope.user[0].email
      $scope.updateUser.phone = $rootScope.user[0].phone

      console.log($scope.updateUser);
      console.log($rootScope.user);

      console.log($scope.updateUser);
      $scope.updateUser.user_id = $rootScope.user[0].user_id
      $scope.userDataUpdate = function(){
          http.request({

          url: './php/settings.php',

          data: $scope.updateUser

        })
        .then(responze => {
          alert("A változtatás sikeres")
          $rootScope.user = responze
          localStorage.setItem('user_pizzaParadise', $rootScope.user);

        })
        .catch(e => console.log(e));
      }
      $scope.userProfiledelete = function(){
          http.request({

          url: './php/profiledelete.php',

          data: {user_id : $rootScope.user[0].user_id}

        })
        .then(responze => {
            //felhasználó tájékoztása kijelentkezésről
            alert("A törlés sikeres")

            //a localstorage-ben lévő adatok eltavolitasa
            localStorage.removeItem('user_pizzaParadise');
            $rootScope.user = null;
            $state.go('home')

        })
        .catch(e => alert.log(e));
      }
    }
  ]);
})(window, angular);
