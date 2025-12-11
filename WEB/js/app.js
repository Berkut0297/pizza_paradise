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
				url: '/login',
        parent: 'root',
				templateUrl: './html/login.html',
				controller: 'loginController'
			})
      .state('register', {
				url: '/register',
        parent: 'root',
				templateUrl: './html/register.html',
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

  //loginController initializálása
  .controller('loginController',[
    '$scope',
    '$rootScope',
    'http',
    '$state',
    function($scope,$rootScope,http,$state){
      $scope.loginBtn = function (){        
        http.request({
          url: './php/login.php',
          data: $scope.model
        })
        .then(response => {
          $rootScope.user = response;
          $scope.isTrue = true;
          $scope.$applyAsync();
          $('#loginModal').modal('show');  
          if ($rootScope.user.userID) 
            $state.go('index')
        })
        .catch(e => {
          $scope.msg = e;
          $('#loginModal').modal('show');
          alert(e)
        })
      }
    }   
  ])

	//registerController initializálása
  .controller('registerController',[
    '$scope',
    'http',
    '$state',
    'util',
    function($scope,http,$state,util) {
      $scope.registerButton = function(){
        let data = util.objFilterByKeys($scope.model,'confirmPassword;showPassword',false);
        http.request({
          url: './php/register.php',
          data: data
        })
        .then(response => {
          $scope.isRegistered = response;
					
          $scope.Message = "Sikeres regisztráció";    
          $scope.$applyAsync();
					$state.go('login')   
					$('#registerModal').modal('show');    
        })
        .catch(e =>{
          $scope.Message = e;
					$scope.$applyAsync();
          $('#registerModal').modal('show');     
        }
        )
      }
    }
  ])
  
	
})(window, angular);