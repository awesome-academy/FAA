$(document).ready(function(){
  $(document).on('click', '.custom-paginate a.page-link', function(e){
    e.preventDefault();

    var params = $(this).attr('href').split('?')[1];
    var tab = params.split('tab=')[1];

    $.ajax({
      dataType: 'html',
      url: $(this).attr('href'),
      method: 'get',
      success: function(data){
        $('#' + tab).html($(data).find('#' + tab));
      },
      error: function(){
        flash = I18n.t("education.users.page_not_found");
        $.growl.error({message: flash});
      }
    })
  })
})

function validateFormLogin() {
  var inputEmail = $('#user_email');
  var inputPassword = $('#user_password');
  var textEmail = inputEmail.val();
  var textPassword = inputPassword.val();
  var flagValidate = true;
  $('.col_full').removeClass('has-error');
  $('span').remove('.help-block');
  if(textEmail.length > 255) {
      flagValidate = false;
      addErrorMessage(inputEmail, I18n.t("devise.sessions.form_login.too_long_255"))
  }
  if(textPassword.length > 255) {
    flagValidate = false;
    addErrorMessage(inputPassword, I18n.t("devise.sessions.form_login.too_long_255"))
  }
  if(textPassword.length < 6) {
    flagValidate = false;
    addErrorMessage(inputPassword, I18n.t("devise.sessions.form_login.too_short_6"));
  }
  if(flagValidate){
    $('#sign-in-user').submit();
  }
  return false;
}

function addErrorMessage(inputField, errorText) {
  var $divFormGroup = inputField.parent();
  $divFormGroup.addClass('has-error');
  $divFormGroup.append('<span class="help-block">' + errorText + '</span>');
}
