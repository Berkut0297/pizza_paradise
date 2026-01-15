; (function (window, angular) {

  'use strict';

  // Application module
  angular.module('app', [
    'ui.router',
    'app.common'
  ])

    // Application config
    .config([
      '$stateProvider',
      '$urlRouterProvider',
      function ($stateProvider, $urlRouterProvider) {
        //registering the allways loadid states of the application
        $stateProvider
          .state('root', {
            abstract: true,
            views: {
              '@': {
                templateUrl: './html/layouts/root.html'
              },
              'header@root': {
                templateUrl: './html/components/header.html',
                controller: 'headerController'
              },
              'footer@root': {
                templateUrl: './html/components/footer.html',
              }
            }
          })
          //registering the states of the application
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
          })
          .state('cart', {
            url: '/cart',
            parent: 'root',
            templateUrl: './html/pages/cart.html',
            controller:'cartController'
          });

        $urlRouterProvider.otherwise('/');
      }
    ])

    // Application run
    .run([
      '$rootScope',
      '$state',
      function ($rootScope, $state) {
        console.log('Run...' + $state.current.name);
        $rootScope.user = JSON.parse(localStorage.getItem('user'));
      }
    ])
    

})(window, angular);