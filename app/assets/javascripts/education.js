// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require jquery-ui/autocomplete
//= require education/feedback_map
//= require education/growl.custom
//= require js-routes
//= require education/projects
//= require cocoon
//= require education/course
//= require education/course_member
//= require education/project_member
//= require education/users
//= require education/posts
//= require education/rates
//= require education/trainings
//= require education/techniques
//= require select2-full
//= require education/home
//= require education/recruitments
//= require i18n
//= require i18n.js
//= require i18n/translations
//= require jquery-ui/datepicker
//= require common

$(document).ready(function(){
  showEditForm('.btn-course-edit', '/education/courses/');
  showEditForm('#btn-training-edit', '/education/trainings/');
  showNewForm('.btn-course-new', '/education/courses/new')
})

function showEditForm(object, path){
  $(object).on('click', function(){
    var id = $(this).data('id');
    $.ajax({
      url: path + id + '/edit' ,
      type:'GET',
      dataType: 'json',
      complete: function(xhr){
        var html_text = xhr.responseText;
        $('#show-edit-form').html(html_text);
        $('#edit-modal').modal('show');
        $('.datetimepicker').datepicker({dateFormat: 'dd/mm/yy'});
      }
    })
  })
}

function showNewForm(object, path){
  $(object).on('click', function(){
    $.ajax({
      url: path,
      type:'GET',
      dataType: 'json',
      complete: function(xhr){
        var html_text = xhr.responseText;
        $('#show-edit-form').html(html_text);
        $('#edit-modal').modal('show');
        $('.datetimepicker').datepicker({dateFormat: 'dd/mm/yy'});
        $('#myModalLabel').text(I18n.t("education.courses.new.create_course"));
      }
    })
  })
}


$(function(){
  return $('form#sign-in-user, form#sign-up-user').bind('ajax:success', function(event, xhr, settings){
    window.location.reload();
  }).bind('ajax:error', function(event, xhr, settings, exceptions) {
    $('.form-group').removeClass('has-error');
    $('span').remove('.help-block');
    var $form = $(this);
    var error_messages;
    if(xhr.responseJSON['error']){
      error_messages = '<div class ="alert alert-danger pull-left">' + xhr.responseJSON['error'] + '</div>';
    }else if(xhr.responseJSON['errors']){
      $.map(xhr.responseJSON['errors'], function(v, k) {
        var element_id = '#user_' + k;
        var $divFormGroup = $form.find(element_id).parent()
        $divFormGroup.addClass('has-error');
        $divFormGroup.append('<span class="help-block">' + v + '</span>');
      });
    }
    $('.alert-messages').html(error_messages)
    $('#div-forms').height($form.height());
  });
});

//= require_tree ../../../vendor/assets/javascripts/js/components
