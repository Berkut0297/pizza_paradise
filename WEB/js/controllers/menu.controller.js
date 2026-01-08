; (function (window, angular) {
  'use strict';
  // Get the existing AngularJS module named 'app'
  angular.module('app')
  // Define a controller called 'menuController'
  .controller('menuController', [
    // Load the next service into the controller:
    '$scope',
    '$state',
    'http',
    //Define a function with the loaded services
    function ($scope, $state, http) {
      // Console log if the controller is loaded
      $scope.getpizzas = function (){
        http.request('./php/getpizzas.php')
            .then(responze=>{
              $scope.pizzas = responze;
              $scope.$applyAsync();
            })
            .catch(e=>console.log(e));
      }
      

      console.log('Menu controller...' + $state.current.name);
    }
  ]);

})(window, angular);
