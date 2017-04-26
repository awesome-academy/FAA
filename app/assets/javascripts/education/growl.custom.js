//= require js/jquery.growl

growl = function(options) {
  if (options == null) {
    options = {};
  }
  return Growl.growl(options);
};

growl.error = function(options) {
  var settings;
  if (options == null) {
    options = {};
  }
  settings = {
    title: "Error!",
    style: "error"
  };
  return growl($.extend(settings, options));
};

growl.notice = function(options) {
  var settings;
  if (options == null) {
    options = {};
  }
  settings = {
    title: "Notice!",
    style: "notice"
  };
  return growl($.extend(settings, options));
};

growl.warning = function(options) {
  var settings;
  if (options == null) {
    options = {};
  }
  settings = {
    title: "Warning!",
    style: "warning"
  };
  return growl($.extend(settings, options));
};
