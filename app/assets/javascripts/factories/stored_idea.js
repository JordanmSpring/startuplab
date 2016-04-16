angular.module('StartupLab').factory('StoredIdea', [ '$http', 'FinancialEntry', 'Channel', 'FundingOption', function($http, FinancialEntry, Channel, FundingOption) {
  return {
    canPublish: true,

    canDraft: true,

    canShare: true,

    canVote: true,

    canComment: true,

    canAddFounders: true,

    isLocal: false,

    financialEntry: FinancialEntry,

    channel: Channel,

    fundingOption: FundingOption,

    basePath: function() {
      return '/api/ideas';
    },

    ideaPath: function(id) {
      if (id) {
        return [ this.basePath(), id.toString() + '.json' ].join('/');
      } else {
        return this.basePath() + '.json';
      }
    },

    all: function() {
      return $http.get(this.ideaPath());
    },

    draft: function() {
      return $http.get(this.basePath() + '/draft.json');
    },

    shared: function() {
      return $http.get(this.basePath() + '/shared.json');
    },

    published: function() {
      return $http.get(this.basePath() + '/published.json');
    },

    find: function(id) {
      return $http.get(this.ideaPath(id));
    },

    publish: function(idea) {
      return $http.post('/api/ideas/' + idea.id + '/publish.json');
    },

    unpublish: function(idea) {
      return $http.post('/api/ideas/' + idea.id + '/unpublish.json');
    },

    vote: function(idea) {
      return $http.post('/api/ideas/' + idea.id + '/vote.json');
    },

    unvote: function(idea) {
      return $http.delete('/api/ideas/' + idea.id + '/vote.json');
    },

    create: function(idea, callback) {
      return $http.post(this.ideaPath(), { idea: idea }).then(function(response) {
        callback(response.data);
      });
    },

    save_from_local: function(idea, callback) {
      return $http.post(this.basePath() + '/save_from_local.json', { idea: idea }).then(function(response) {
        callback(response.data);
      });
    },

    delete: function(idea) {
      return $http.delete(this.ideaPath(idea.id));
    },

    update: function(idea) {
      return $http.patch(this.ideaPath(idea.id), { idea: idea });
    }
  };
}]);
