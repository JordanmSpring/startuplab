angular.module('StartupLab').factory('Idea', [ '$http', function($http) {
  return {
    idea_path: function(id) {
      return '/ideas/' + id.toString() + '.json';
    },

    all: function() {
      return $http.get('/ideas.json');
    },

    find: function(id) {
      return $http.get(this.idea_path(id));
    },

    update: function(idea) {
      return $http.patch(this.idea_path(idea.id), { idea: idea });
    }
  };
}]);
