$(document).ready(function(){
  $('.search_education_users').on('keyup', '#q_name_or_email_cont', function() {
    $.get($('#q_name_or_email_cont').attr('action'),
      $('#q_name_or_email_cont').serialize(), null, 'script');
    return false;
  });

  $('.management-user-role').on('change', function(e){
    var status_button = $(this).closest('td').siblings('.action-user-edu').find('button')[0]
    var id = status_button.dataset.id
    var status = status_button.dataset.status === 'active' ? 'blocked' : 'active'
    var alert_messages = I18n.t('education.javascripts.change_role')
    var role = $(this).val()
    if(confirm(alert_messages)) {
      edit_user(id, status, role)
    }
  })

  $('#list_education_users').on('click', '.user_education_status', function(){
    var id = this.dataset.id
    var status = this.dataset.status
    var username = this.dataset.username
    var role_select = $(this).closest('td').siblings('.management-user-role-td').find('select')[0]
    var role = $(role_select).val()
    switch(status) {
      case "active":
        var status_alert = username + ' ' + I18n.t('education.javascripts.active_alert');
        break;
      case "blocked":
        var status_alert = username + ' ' + I18n.t('education.javascripts.block_alert');
        break;
    }
    if(confirm(status_alert)) {
      edit_user(id, status, role)
    }
  });

  function edit_user(id, status, role){
    $.ajax({
      type: 'patch',
      url: '/education/management/users/' + id,
      data: {id: id, user: {education_status: status, role: role}},
      success: function(data) {
        if(data['status'] === 200) {
          $.growl.notice({title: '', message: data['flash']});
          $('#user-edu-stt-'+id).load(window.location + ' #user-edu-status-label-'+id);
          $('#action-user-edu-stt-'+id).load(window.location + ' #user_education_status_'+id);
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
