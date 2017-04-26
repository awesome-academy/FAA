$(document).ready(function() {
  $('.delete-feedback').on('click', function() {
    var id = this.dataset.id;
    var status_alert = I18n.t('education.javascripts.feedback_alert');
    if(confirm(status_alert)) {
      delete_feedback(id);
    }
  });
});

function delete_feedback(id) {
  $.ajax({
    type: 'DELETE',
    url: '/education/management/feedbacks/' + id,
    dataType: 'json',
    success: function(data) {
      if(data['status'] === 200) {
        $('#feedback-' + id).remove();
        $.growl.notice({title: '', message: data['flash']});
      }
    },
    error: function(error_message) {
      $.growl.error({message: error_message});
      location.reload();
    }
  });
};
