; (function (window, angular) {
  'use strict';
  // Get the existing AngularJS module named 'app'
  angular.module('app')
  // Define a controller called 'registerController'
  .controller('registerController', [
    // Load the next service into the controller:
    '$scope',
    'http',
    '$state',
    'util',
    //Define a function with the loaded services
    function ($scope, http, $state, util) {
      //Defind the registerButton
      $scope.registerButton = function () {
        //Define the sending data and filtering 
        //excluding the confirm password and show password
        //that is neccessary because we don't want to send 2 times the password to tha database
        let data = util.objFilterByKeys($scope.model, 'confirmPassword;showPassword', false);
        //http request
        http.request({
          //php file root
          url: './php/register.php',
          //Define the sending data
          data: data
        })
        //Response
        .then(response => {
          $scope.isRegistered = response;
          //messaging if the registeration is success
          $scope.Message = "Sikeres regisztráció";
          //applying the Async function
          $scope.$applyAsync();
          //redirect to login
          $state.go('login')
          //$('#registerModal').modal('show');
        })
        //Error
        .catch(e => {
          //messaging the error
          $scope.Message = e;
          //$('#registerModal').modal('show');
        }
        )
      }
    }
  ])

})(window, angular);
