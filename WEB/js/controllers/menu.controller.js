; (function (window, angular) {
  'use strict';
  angular.module('app')
  .controller('menuController', [
    '$scope',
    '$state',
    function ($scope, $state) {
      console.log('Menu controller...' + $state.current.name);
    }
  ]);

})(window, angular);
