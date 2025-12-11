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
            templateUrl: './html/layouts/root.html'
          },
          'header@root': {
            templateUrl: './html/components/header.html'
          },
          'footer@root': {
            templateUrl: './html/components/footer.html', 
            controller: 'footerController'
          }
        }
      })
			.state('home', {
				url: '/',
        parent: 'root',
				templateUrl: './html/pages/home.html',
				controller: 'homeController'
			})
      .state('menu', {
				url: '/menu',
        parent: 'root',
				templateUrl: './html/pages/menu.html',
				controller: 'menuController'
			})
      .state('login', {
				url: '/login',
        parent: 'root',
				templateUrl: './html/pages/login.html',
				controller: 'loginController'
			})
      .state('register', {
				url: '/register',
        parent: 'root',
				templateUrl: './html/pages/register.html',
				controller: 'registerController'
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

})(window, angular);