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
      .state('page1', {
				url: '/page1',
        parent: 'root',
				templateUrl: './html/page1.html',
				controller: 'page1Controller'
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
      console.log('Controller...' + $state.current.name);
    }
  ])

  // Page1 controller
  .controller('page1Controller', [
    '$scope',
    '$state',
    function($scope, $state) {
      console.log('Controller...' + $state.current.name);
    }
  ]);
	
})(window, angular);