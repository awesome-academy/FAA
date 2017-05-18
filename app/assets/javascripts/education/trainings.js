$(document).ready(function() {
  var location = window.location.href
  if(location.indexOf('management') > -1) {
    $('#page-menu').addClass('education-management-trainings')
  } else {
    $('#page-menu').addClass('education-trainings')
  }
  $(document).on('click','.delete-training', {}, function() {
    var id = this.dataset.id;
    var status_alert = I18n.t('education.javascripts.training_alert');
    if(confirm(status_alert)) {
      delete_training(id);
    }
  });

  $('.training-search input').on('keyup',function() {
    var training_search = $(this).val();
    data = {training_search: training_search}
    $.get('/education/management/trainings', data, null, 'script');
  });

  $('#training_search').on('keyup', function(){
    var training_search = $(this).val();
    data = {training_search: training_search}
    $.get('/education/trainings', data, null, 'script');
  })
});

function delete_training(id) {
  $.ajax({
    type: 'DELETE',
    url: '/education/management/trainings/' + id,
    dataType: 'json',
    success: function(data) {
      if(data['status'] === 200) {
        $('#training-' + id).remove();
        $('#wrapper').trigger('resize');
        $.growl.notice({title: '', message: data['flash']});
      }
    },
    error: function(error_message) {
      $.growl.error({message: error_message});
      location.reload();
    }
  });
};
