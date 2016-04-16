angular.module('StartupLab').factory('LocalFundingOption', [ 'localStorageService', '$q', function(localStorageService, $q) {

  // TODO: Remove this duplication
  var LOCAL_IDEA_KEY = 'localIdea';

  return {
    save: function(idea, funding_options) {
      return $q(function(resolve, reject){
        var localIdea = localStorageService.get(LOCAL_IDEA_KEY);
        localIdea.fundingOptions = funding_options;
        localStorageService.set(LOCAL_IDEA_KEY, localIdea);
        resolve(localIdea, funding_options);
      });
    }
  };
}]);
