;(function(window, angular) {
  'use strict'; 
  // Get the existing AngularJS module named 'app'
  angular.module('app')
  // Define a controller called 'homeController'
  .controller('homeController', [
    // Load the next service into the controller:
    '$scope',
    //Define a function with the loaded services 
    function($scope) {
      // Console log if the controller is loaded
      console.log('Home controller...');
    }
  ]);
})(window, angular);
