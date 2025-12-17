; (function (window, angular) {
  'use strict';
  // Get the existing AngularJS module named 'app'
  angular.module('app')
    // Define a controller called 'loginController'
    .controller('loginController', [
      // Load the next service into the controller:
      '$scope',
      '$rootScope',
      'http',
      '$state',
      //Define a function with the loaded services
      function ($scope, $rootScope, http, $state) {
        //Define the loginBtn function
        $scope.loginBtn = function () {
          //http request
          http.request({
            //php file root
            url: './php/login.php',
            //Define the sending data
            data: {
              email: $scope.model.email,
              password: $scope.model.password
            }                  
          })
          //Response
          .then(response => {
            $rootScope.user = response;
            //console log the response
            console.log(response);
            //applying the Async function
            $scope.$applyAsync(); 
            //$('#loginModal').modal('show');
          })
          //Error
          .catch(e => {
            //messiging the error
            $scope.msg = e;
            //$('#loginModal').modal('show');
            alert(e)
          })
        }
      }
    ])

})(window, angular);
