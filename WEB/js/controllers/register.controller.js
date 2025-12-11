; (function (window, angular) {
  'use strict';

  controller('registerController', [
    '$scope',
    'http',
    '$state',
    'util',
    function ($scope, http, $state, util) {
      $scope.registerButton = function () {
        let data = util.objFilterByKeys($scope.model, 'confirmPassword;showPassword', false);
        http.request({
          url: './php/register.php',
          data: data
        })
          .then(response => {
            $scope.isRegistered = response;

            $scope.Message = "Sikeres regisztráció";
            $scope.$applyAsync();
            $state.go('login')
            $('#registerModal').modal('show');
          })
          .catch(e => {
            $scope.Message = e;
            $scope.$applyAsync();
            $('#registerModal').modal('show');
          }
          )
      }
    }
  ])

})(window, angular);
