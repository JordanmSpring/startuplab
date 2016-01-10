
angular.module('StartupLab').factory('FinancialEntry', [ '$http', function($http) {
  return {
    idea_financial_entry_path: function(idea, entry) {
      return '/api/ideas/' + idea.id + '/financial_entries/' + entry.id + '.json';
    },

    destroy: function(idea, entry) {
      return $http.delete(this.idea_financial_entry_path(idea, entry));
    },

    save: function(idea, entry) {
      console.log(idea)
      console.log(entry)
      return $http.patch(this.idea_financial_entry_path(idea, entry), { financial_entry: entry });
    }
  };
}]);
