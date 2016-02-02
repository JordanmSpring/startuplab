angular.module('StartupLab').config([
  "$httpProvider", function($httpProvider, $location) {
    $httpProvider.interceptors.push(function($q, $location) {
      return {
        'responseError': function(rejection) {
          if (rejection.status === 401) {
            $location.path('/sign-in');
          }

          if (rejection.status === 403) {
            $location.path('/unauthorized');
          }

          if (rejection.status === 404) {
            $location.path('/not-found');
          }

          if (rejection.status === 500) {
            $location.path('/unexpected-error');
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
