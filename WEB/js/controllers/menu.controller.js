;(function(window, angular) {
  'use strict';

  controller('menuController', [
    '$scope',
    '$state',
    function($scope, $state) {
      console.log('Menu controller...' + $state.current.name);
    }
  ])

})(window, angular);
