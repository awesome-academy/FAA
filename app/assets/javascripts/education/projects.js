$(document).ready(function () {
  effect();
  load_more();
});

function effect() {
  $('ul[data-liffect] li').each(function (i) {
    $(this).attr('style', 'animation-delay:' + i * 100 + 'ms;');
    if (i === $('ul[data-liffect] li').size() -1) {
      $('ul[data-liffect]').addClass('play')
  }});
}

function load_more() {
  size = $('.load-more-project').length;
  x = 12;
  if(x >= size) {
    $('#more-project').hide();
    $('#next-project').show();
  }
  else {
    $('#next-project').hide();
    $('#more-project').show();
  };
  $('.load-more-project:lt(' + size + ')').hide();
  $('.load-more-project:lt(' + x + ')').show();
  $('.read-more').click(function () {
    x = (x <= size) ? x + 4 : size;
    $('.load-more-project:lt(' + x + ')').show();
    if(x >= size){
      $('#more-project').hide();
      $('#next-project').show();
      $("#back-project").show();
    }
  });
}

$(document).ready(function() {
  $('.delete-project').on('click', function() {
    var id = this.dataset.id;
    var status_alert = I18n.t('education.javascripts.project_alert');
    if(confirm(status_alert)) {
      delete_project(id);
    }
  })

  var onAddFile;
  onAddFile = function(event) {
    var file, thumbContainer, url;
    file = event.target.files[0];
    url = URL.createObjectURL(file);
    thumbContainer = $(this).parent().parent();
    if (thumbContainer.find('img').length === 0) {
      return thumbContainer.append('<img src="' + url + '" />');
    } else {
      return thumbContainer.find('img').attr('src', url);
    }
  };
  $('input[type=file]').each(function() {
    return $(this).change(onAddFile);
  });
  $('body').on('cocoon:after-insert', function(e, addedPartial) {
    return $('input[type=file]', addedPartial).change(onAddFile);
  });
  $('a.add_fields').data('association-insertion-method', 'append');
});

function delete_project(id) {
  $.ajax({
    type: "DELETE",
    url: "/education/management/projects/" + id,
    dataType: "json",
    success: function(data) {
      if(data['status'] === 200) {
        $('#project-' + id).remove();
        $('#wrapper').trigger('resize');
        $.growl.notice({title: '', message: data['flash']});
      }
    },
    error: function(error_message) {
      $.growl.error({message: error_message});
      location.reload();
    }
  });
}

$(document).ready(function() {
  $('#projects-search-txt').on('keyup',function(e) {
    var term = $(this).val();
    var data = {term: term};
    $.get('projects', data, null, 'script');
  });
});
