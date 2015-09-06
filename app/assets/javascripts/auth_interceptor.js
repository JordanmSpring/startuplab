angular.module('StartupLab').config([
  "$httpProvider", function($httpProvider, $location) {
    $httpProvider.interceptors.push(function($q, $location) {
      return {
        'responseError': function(rejection) {
          if (rejection.status === 401) {
            $location.path('/sign-in');
          }

          if (rejection.status === 404) {
            alert('Not Found');
            $location.path('/');
          }

          if (rejection.status === 500) {
            alert('An Error Occurred');
          }

          return $q.reject(rejection);
        },

        'response': function(config) {
          return config;
        },
      }
    });
  }
]);
