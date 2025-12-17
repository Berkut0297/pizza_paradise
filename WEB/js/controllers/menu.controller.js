; (function (window, angular) {
  'use strict';
  // Get the existing AngularJS module named 'app'
  angular.module('app')
  // Define a controller called 'menuController'
  .controller('menuController', [
    // Load the next service into the controller:
    '$scope',
    '$state',
    //Define a function with the loaded services
    function ($scope, $state) {
      // Console log if the controller is loaded
      console.log('Menu controller...' + $state.current.name);
    }
  ]);

})(window, angular);
