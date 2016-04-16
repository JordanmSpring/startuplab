angular.module('StartupLab').factory('LocalChannel', [ 'localStorageService', '$q', function(localStorageService, $q) {

  // TODO: Remove this duplication
  var LOCAL_IDEA_KEY = 'localIdea';

  return {
    save: function(idea, channels) {
      return $q(function(resolve, reject){
        var localIdea = localStorageService.get(LOCAL_IDEA_KEY);
        localIdea.channels = channels;
        localStorageService.set(LOCAL_IDEA_KEY, localIdea);
        resolve(localIdea, channels);
      });
    }
  };
}]);
