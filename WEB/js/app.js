;(function(window, angular) {

  'use strict';

  // Application module
	angular.module('app', [
		'ui.router'
	])

	// Application config
	.config([
    '$stateProvider', 
    '$urlRouterProvider', 
    function($stateProvider, $urlRouterProvider) {

      $stateProvider
      .state('root', {
        abstract: true,
        views: {
          '@': {
            templateUrl: './html/root.html'
          },
          'header@root': {
            templateUrl: './html/header.html'
          },
          'footer@root': {
            templateUrl: './html/footer.html'
          }
        }
      })
			.state('home', {
				url: '/',
        parent: 'root',
				templateUrl: './html/home.html',
				controller: 'homeController'
			})
      .state('menu', {
				url: '/menu',
        parent: 'root',
				templateUrl: './html/menu.html',
				controller: 'menuController'
			})
      .state('login', {
				url: '/',
        parent: 'root',
				templateUrl: './html/login.html',
				controller: 'loginController'
			});
      
      $urlRouterProvider.otherwise('/');
    }
  ])

	// Application run
  .run([
    '$rootScope',
    '$state',
    function($rootScope, $state) {
			console.log('Run...' + $state.current.name);
    }
  ])

  // Home controller
  .controller('homeController', [
    '$scope',
    '$state',
    function($scope, $state) {
      console.log('Home controller...' + $state.current.name);
    }
  ])

  // menu controller
  .controller('menuController', [
    '$scope',
    '$state',
    function($scope, $state) {
      console.log('Menu controller...' + $state.current.name);
    }
  ])
  //login controller
  .controller('loginController', [
    '$scope',
    '$state',
    function($scope, $state) {
      console.log('login controller...' + $state.current.name);
    }
  ]);
	
})(window, angular);