angular.module('StartupLab').factory('Preloader', function() {

  function Preloader(imageLocations) {
    this.imageLocations = imageLocations;
  }

  Preloader.preloadImages = function(imageLocations){
    var preloader = new Preloader(imageLocations);
    preloader.load();
  };

  Preloader.prototype = {
    load: function(){
      for(var i = 0; i < this.imageLocations.length; i++){
        this.loadImageLocation(this.imageLocations[i]);
      }
    },
    loadImageLocation: function(imageLocation){
      $(new Image()).prop('src', imageLocation);
    }
  };

  return Preloader;

});
