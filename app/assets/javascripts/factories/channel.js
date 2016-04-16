
angular.module('StartupLab').factory('Channel', [ '$http', function($http) {
  return {
    channels_path: function(idea) {
      return '/api/ideas/' + idea.id + '/channels';
    },

    save: function(idea, channels) {
      return $http({
        method: 'POST',
        url: this.channels_path(idea),
        data: { channels: channels }
      }).catch(function() {
        alert('Could not save channels');
      });
    }
  };
}]);
