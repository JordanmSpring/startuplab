
angular.module('StartupLab').factory('Problem', [ '$http', function($http) {
  return {
    create: function(idea, problem) {
      return $http({
        method: 'POST',
        url: '/ideas/' + idea.id + '/problems',
        data: { problem: problem }
      });
    }

  };
}]);
