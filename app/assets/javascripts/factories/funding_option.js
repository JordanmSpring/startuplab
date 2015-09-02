
angular.module('StartupLab').factory('FundingOption', [ '$http', function($http) {
  return {
    funding_options_path: function(idea) {
      return '/api/ideas/' + idea.id + '/funding_options';                    
    },

    save: function(idea, funding_options) {
      return $http({
        method: 'POST',
        url: this.funding_options_path(idea),
        data: { funding_options: funding_options }
      }).error(function() {
        alert('Could not save funding_options');
      });
    }
  };
}]);
