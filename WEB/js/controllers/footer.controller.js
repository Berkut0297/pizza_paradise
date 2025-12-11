;(function(window, angular) {
  'use strict';

  angular.module('app')
  .controller('footerController', [
    '$scope',
    function($scope) {
      const date = new Date();
      $scope.currentYear = date.getFullYear();
      console.log('Footer controller...');
    }
  ]);

})(window, angular);
