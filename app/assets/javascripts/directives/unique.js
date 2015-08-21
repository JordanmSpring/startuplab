
angular.module('StartupLab').directive("uniqueEmail", [ 'User', function(User) {
  return {
    retrict: 'A',
    require: "ngModel",
    link: function(scope, element, attributes, ngModel) {
      ngModel.$parsers.push(function(emailValue) {
        var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        ngModel.$setValidity('uniqueEmail', true);
        if (filter.test(emailValue)) {
          User.existsWithEmail(emailValue, function(exists) {
            ngModel.$setValidity('uniqueEmail', !exists);
          });
        }
        return emailValue;
      });
    }
  };
}]);
