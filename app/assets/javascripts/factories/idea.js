angular.module('StartupLab')
.factory('Idea', [ 'Session', 'StoredIdea', 'LocalIdea', function(Session, StoredIdea, LocalIdea) {

  return {
    provider: function() {
      if (Session.isAuthenticated()) {
        return StoredIdea;
      } else {
        return LocalIdea;
      }
    },
    stored: function() {
      return StoredIdea;
    },
    local: function() {
      return LocalIdea;
    }
  };

}]);
