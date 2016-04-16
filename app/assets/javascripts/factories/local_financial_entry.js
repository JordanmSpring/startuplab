angular.module('StartupLab').factory('LocalFinancialEntry', [ 'localStorageService', '$q', function(localStorageService, $q) {

  var LOCAL_IDEA_KEY = 'localIdea';

  return {
    // TODO: Refactor to remove indexes
    destroy: function(idea, entry) {
      return $q(function(resolve, reject){
        var localIdea = localStorageService.get(LOCAL_IDEA_KEY);
        if (localIdea.financialEntries[entry.group].indexOf(entry) > -1) {
          localIdea.financialEntries[entry.group].splice(entry.id, 1);
        }
        localStorageService.set(LOCAL_IDEA_KEY, localIdea);
        resolve();
      });
    },

    save: function(idea, entry) {
      return $q(function(resolve, reject){
        var localIdea = localStorageService.get(LOCAL_IDEA_KEY);
        localIdea.financialEntries[entry.group][entry.id] = entry;
        localStorageService.set(LOCAL_IDEA_KEY, localIdea);
        resolve();
      });
    },

    create: function(idea, entry) {
      return $q(function(resolve, reject){
        var localIdea = localStorageService.get(LOCAL_IDEA_KEY);
        var financialEntries = localIdea.financialEntries || {};
        if (!financialEntries[entry.group]) {
          financialEntries[entry.group] = [];
        }
        entry.id = financialEntries[entry.group].length;
        financialEntries[entry.group].push(entry);
        localIdea.financialEntries = financialEntries;
        localStorageService.set(LOCAL_IDEA_KEY, localIdea);
        resolve({data: entry});
      });
    }

  };
}]);
