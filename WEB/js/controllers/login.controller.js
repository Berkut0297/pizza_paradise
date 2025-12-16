; (function (window, angular) {
  'use strict';
  angular.module('app')
    .controller('loginController', [
      '$scope',
      '$rootScope',
      'http',
      '$state',
      function ($scope, $rootScope, http, $state) {
        $scope.loginBtn = function () {
          http.request({
            url: './php/login.php',
            data: {
              email: $scope.model.email,
              password: $scope.model.password
            }                  
          })
          .then(response => {
            $rootScope.user = response;
            console.log(response);
            $scope.$applyAsync(); 
            //$('#loginModal').modal('show');
          })
          .catch(e => {
            $scope.msg = e;
            //$('#loginModal').modal('show');
            alert(e)
          })
        }
      }
    ])

})(window, angular);
