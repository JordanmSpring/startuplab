angular.module("StartupLab").factory("Gravatar", function GravatarFactory() {
  var avatarSize = 80; // Default size
  var avatarUrl = "http://www.gravatar.com/avatar/";

  return function(email, size) {
    if (!size) size = avatarSize;
    return avatarUrl + CryptoJS.MD5(email) + "?size=" + avatarSize.toString();
  };
});
