$(document).ready(function(){
   $('#course_search').on('keyup', function() {
    var course_search = $(this).val();
    var name_course = $('#course_name').val();
    var status_course = $('#course_status').val();
    var data = {course_search: course_search, name_course: name_course, status_course: status_course};
    $.get('/education/management/course_registers/', data, null, 'script');
  });

  $('#course_status').on('change', function() {
    var status_course = this.value;
    var name_course = $('#course_name').val();
    var course_search = $('#course_search').val();
    var data = {status_course: status_course, name_course: name_course, course_search: course_search};
    $.get('/education/management/course_registers/', data, null, 'script');
  });

  $('#course_name').on('change', function() {
    var name_course = $(this).val();
    var status_course = $('#course_status').val();
    var course_search = $('#course_search').val();
    var data = {name_course: name_course, status_course: status_course, course_search: course_search};
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
          if(data.course_register.status == 'registered') {
            var label_stt = 'warning';
            var text_stt = I18n.t("education.course_status.registered");
            var button_text = I18n.t("education.course_status.send_contact");
            var label_btn = 'success'
            var button_data_stt = 'contacted'
          }
          else{
            var label_stt = 'success';
            var text_stt = I18n.t("education.course_status.contacted");
            var button_text = I18n.t("education.course_status.reject_contact");
            var label_btn = 'warning'
            var button_data_stt = 'registered'
          }
          $('#course-edu-stt-'+id).html(`<span class="label label-${label_stt}"
            id="course-status-label-${data.course_register.id}">
            ${text_stt}</span>`);
          $('#action-course-edu-stt-'+id).html(`<button
            class="btn btn-${label_btn} send_contact_register"
            id="send_contact_register_${data.course_register.id}"
            data-id="${data.course_register.id}"
            data-username="${data.course_register.name}"
            data-status="${button_data_stt}">
            ${button_text}</button>`);
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
