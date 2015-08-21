angular.module('StartupLab').config([
  "$httpProvider", function($httpProvider, $location) {
    $httpProvider.interceptors.push(function($q, $location) {
      return {
        'responseError': function(rejection) {
          console.log('REJECT', rejection.status);
          if (rejection.status === 401) {
            $location.path('/sign-in');
          }

          if (rejection.status === 404) {
            alert('Not Found');
            $location.path('/');
          }
          return $q.reject(rejection);
        },

        'response': function(config) {
          console.log(config);
          return config;
        },
      }
    });
  }
]);
