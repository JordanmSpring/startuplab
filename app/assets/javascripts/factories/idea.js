angular.module('StartupLab').factory('Idea', [ '$http', function($http) {
  return {
    idea_path: function(id) {
      return '/api/ideas/' + id.toString() + '.json';
    },

    all: function() {
      return $http.get('/api/ideas.json');
    },

    find: function(id) {
      return $http.get(this.idea_path(id));
    },

    update: function(idea) {
      return $http.patch(this.idea_path(idea.id), { idea: idea });
    }
  };
}]);
