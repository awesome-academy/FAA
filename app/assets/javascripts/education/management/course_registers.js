$(document).ready(function(){
  $('.search-form-course').on('keyup', '#q_name_or_email_cont', function() {
    $.get($('#q_name_or_email_cont').attr('action'),
      $('#q_name_or_email_cont').serialize(), null, 'script');
    return false;
  });

  $('#filter-course').on('change', function() {
    var status_course = $('.status-course').val();
    var data = {status_course: status_course};
    $.get('/education/management/course_registers/', data, null, 'script');
  });

  $('#list_course_register').on('click', '.send_contact_register', function(){
    var id = this.dataset.id;
    var status = this.dataset.status;
    var username = this.dataset.username;
    switch(status) {
      case "contacted":
        var status_alert = I18n.t('education.javascripts.send_alert') + ' ' + username;
        break;
      case "registered":
        var status_alert = I18n.t('education.javascripts.reject_alert') + ' ' + username;
        break;
    }
    if(confirm(status_alert)) {
      update_status(id, status)
    }
  });

  function update_status(id, status){
    $.ajax({
      type: 'patch',
      url: '/education/management/course_registers/' + id,
      data: {id: id, course_register: {status: status}},
      success: function(data) {
        if(data['status'] === 200) {
          $.growl.notice({title: '', message: data['flash']});
          $('#course-edu-stt-'+id).load(window.location + ' #course-status-label-'+id);
          $('#action-course-edu-stt-'+id).load(window.location + ' #send_contact_register_'+id);
        }
        else {
          $.growl.error({title: '', message: data['flash']});
          location.reload();
        }
      },
      error: function(error_message) {
        $.growl.error({message: error_message});
        location.reload();
      }
    });
  }
});
