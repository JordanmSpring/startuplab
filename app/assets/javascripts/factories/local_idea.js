angular.module('StartupLab').factory('LocalIdea',
  [ 'localStorageService', '$q', 'LocalFinancialEntry', 'LocalChannel', 'LocalFundingOption', 'StoredIdea',
  function(localStorageService, $q, LocalFinancialEntry, LocalChannel, LocalFundingOption, StoredIdea) {

  var LOCAL_IDEA_KEY = 'localIdea';

  return {

    canPublish: false,

    canShare: false,

    canVote: false,

    canComment: false,

    canAddFounders: false,

    isLocal: true,

    financialEntry: LocalFinancialEntry,

    channel: LocalChannel,

    fundingOption: LocalFundingOption,

    create: function(idea, callback) {
      idea.id = 'local';
      idea.canEdit = true;
      localStorageService.set(LOCAL_IDEA_KEY, idea);
      callback(idea);
    },

    findSynchronous: function() {
      return localStorageService.get(LOCAL_IDEA_KEY);
    },

    find: function(id) {
      if (id == 'local') {
        var self = this;
        return $q(function(resolve, reject){
          var localIdea = self.findSynchronous();
          if (localIdea) {
            resolve({data: localIdea});
          }
        });
      } else {
        // Forward call to StoredIdea
        return StoredIdea.find(id);
      }
    },

    delete: function(idea) {
      localStorageService.remove(LOCAL_IDEA_KEY);
    },

    update: function(idea) {
      return $q(function(resolve, reject){
        var localIdea = localStorageService.set(LOCAL_IDEA_KEY, idea);
        if (localIdea) {
          resolve({data: localIdea});
        }
      });
    },

    // Forward call to StoredIdea
    all: function() {
      return StoredIdea.all();
    },

    draft: function() {
      return StoredIdea.draft();
    },

    shared: function() {
      return StoredIdea.shared();
    },

    published: function() {
      return StoredIdea.published();
    },

  };

}]);
