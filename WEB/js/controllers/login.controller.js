; (function (window, angular) {
  'use strict';
  angular.module('app')
  controller('loginController', [
    '$scope',
    '$rootScope',
    'http',
    '$state',
    function ($scope, $rootScope, http, $state) {
      $scope.loginBtn = function () {
        http.request({
          url: './php/login.php',
          data: $scope.model
        })
          .then(response => {
            $rootScope.user = response;
            $scope.isTrue = true;
            $scope.$applyAsync();
            $('#loginModal').modal('show');
            if ($rootScope.user.userID)
              $state.go('index')
          })
          .catch(e => {
            $scope.msg = e;
            $('#loginModal').modal('show');
            alert(e)
          })
      }
    }
  ])

})(window, angular);
