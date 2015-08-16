
angular.module('StartupLab').factory('Problem', [ '$http', function($http) {
  return {
    problems_path: function(idea) {
      return '/ideas/' + idea.id + '/problems';                    
    },

    all: function(idea) {
      return $http(
        { method: 'GET', url: this.problems_path(idea) }
      ).error(function() {
        alert('Could not load');
      });
    },

    create: function(idea, problem) {
      return $http({
        method: 'POST',
        url: this.problems_path(idea),
        data: { problem: problem }
      }).error(function() {
        alert('Could not save problem');
      });
    }
  };
}]);
