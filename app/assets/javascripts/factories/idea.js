angular.module('StartupLab').factory('Idea', [ '$http', function($http) {
  return {
    basePath: function() {
      return '/api/ideas';
    },

    ideaPath: function(id) {
      if (id) {
        return [ this.basePath(), id.toString() + '.json' ].join('/');
      } else {
        return this.basePath() + '.json';
      }
    },

    all: function() {
      return $http.get(this.ideaPath());
    },

    draft: function() {
      return $http.get(this.basePath() + '/draft.json');
    },

    published: function() {
      return $http.get(this.basePath() + '/published.json');
    },

    find: function(id) {
      return $http.get(this.ideaPath(id));
    },

    create: function(idea, callback) {
      return $http.post(this.ideaPath(), { idea: idea }).then(function(response) {
        callback(response.data);
      });
    },

    update: function(idea) {
      return $http.patch(this.ideaPath(idea.id), { idea: idea });
    }
  };
}]);
