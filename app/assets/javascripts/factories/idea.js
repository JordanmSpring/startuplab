angular.module('StartupLab').factory('Idea', [ '$http', function($http) {
  return {
    idea_path: function(id) {
      var base = '/api/ideas';
      if (id) {
        return [ base, id.toString() + '.json' ].join('/');
      } else {
        return base + '.json';
      }
    },

    all: function() {
      return $http.get(this.idea_path());
    },

    find: function(id) {
      return $http.get(this.idea_path(id));
    },

    create: function(idea, callback) {
      return $http.post(this.idea_path(), { idea: idea }).then(function(response) {
        callback(response.data);
      });
    },

    update: function(idea) {
      return $http.patch(this.idea_path(idea.id), { idea: idea });
    }
  };
}]);
