console.log('FACT');
angular.module('StartupLab').factory('Idea', [ '$http', function($http) {
  return {
    all: function() {
      return $http({method: 'GET', url: '/ideas.json'});
    },

    find: function(id) {
      return $http({method: 'GET', url: '/ideas/' + id.toString() + '.json'});
    }
  };
}]);
