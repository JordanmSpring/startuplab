
angular.module('StartupLab').directive('slSupportLink', function() {
  return {
    restrict: 'A',
    link: function(scope, element, attrs) {
      element.bind('click', function() {
        // Launch the ZenDesk contact widget on click.
        zE.activate();
      });
    }
  };
});
