$(document).ready(function () {
  $(function() {
    new app.Projects;
  });
});

var app = window.app = {};

app.Projects = function() {
  this._input = $('#projects-search-txt');
  this._initAutocomplete();
};

app.Projects.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: Routes.education_projects_path(),
        appendTo: '#projects-search-results',
        select: $.proxy(this._select, this)
      })
    this._input.autocomplete().data("uiAutocomplete")._renderItem = $.proxy(this._render, this);
  },

  _render: function(ul, item) {
    var markup = [
      '<a href="' + Routes.education_project_path(item.id) + '">',
      '<span class="img">',
        '<img src="' + item.image_url + '" />',
      '</span>',
      '<span class="name">' + item.name + '</span>',
      '<span class="description">' + text_truncate(item.description, 35) + '</span>',
      '<span class="plat-form">' + item.plat_form + '</span>',
      '</a>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  },

  _select: function(e, ui) {
    this._input.val(ui.item.name);
    return false;
  },
};

text_truncate = function(str, length, ending) {  
  if (length == null) {
    length = 100;  
  }  
  if (ending == null) {
    ending = '...';
  }  
  if (str.length > length) {
    return str.substring(0, length - ending.length) + ending;
  }
  else {
    return str;
  }
};

$(document).ready(function() {
  $('#projects-search-txt').on('keypress',function(e) {
    var enter = 13
    if(e.type === 'keypress' && e.keyCode === enter)
    {
      window.location.href = '/education/projects?term=' + $(this).val();
    }
  });
});
