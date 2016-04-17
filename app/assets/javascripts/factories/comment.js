angular.module('StartupLab').factory('Comment', [ '$http', function($http) {
  return {
    comments_path: function(ideaId, id) {
      var base = '/api/ideas/' + ideaId + '/comments';
      if (id) {
        return [ base, id.toString() + '.json' ].join('/');
      } else {
        return base + '.json';
      }
    },

    all: function(idea) {
      return $http.get(this.comments_path(idea.id));
    },

    create: function(idea, comment, callback) {
      return $http.post(this.comments_path(idea.id), { comment: comment }).then(function(response) {
        callback(response.data);
      });
    }
  };
}]);
