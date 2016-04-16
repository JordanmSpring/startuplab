angular.module('StartupLab').factory('FinancialEntry', [ '$http', function($http) {
  return {
    entryPath: function(idea, entry) {
      if (entry) {
        return '/api/ideas/' + idea.id + '/financial_entries/' + entry.id + '.json';
      } else {
        return '/api/ideas/' + idea.id + '/financial_entries.json';
      }
    },

    destroy: function(idea, entry) {
      return $http.delete(this.entryPath(idea, entry));
    },

    save: function(idea, entry) {
      return $http.patch(this.entryPath(idea, entry), { financial_entry: entry });
    },

    create: function(idea, entry) {
      return $http.post(this.entryPath(idea), { financial_entry: entry });
    }

  };
}]);
