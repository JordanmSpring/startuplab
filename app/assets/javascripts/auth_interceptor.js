angular.module('StartupLab').config([
  "$httpProvider", function($httpProvider, $location) {
    $httpProvider.interceptors.push(function($q, $location) {
      return {
        'responseError': function(rejection) {
          console.log('REJECT', rejection.status);
          $location.path('/sign-in');
          return $q.reject(rejection);
        },

        'request': function(config) {
          console.log(config);
          return config;
        },
      }
    });
  }
]);
