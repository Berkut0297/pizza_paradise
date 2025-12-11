;(function(window, angular) {
  'use strict';

  angular.module('app')
  .controller('homeController', [
    '$scope',
    function($scope) {
      console.log('Home controller...');
    }
  ]);

})(window, angular);
