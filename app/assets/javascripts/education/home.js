$(document).ready(function(){
  $('#course_register_course_id').select2()
});

$(function() {  
  var $formLogin = $('#sign-in-user');
  var $formRegister = $('#sign-up-user');
  var $divForms = $('#div-forms');
  var $modalAnimateTime = 300;
  var $msgAnimateTime = 150;
  
  $('#login-register-btn').click( function () { modalAnimate($formLogin, $formRegister) });
  $('#register-login-btn').click( function () { modalAnimate($formRegister, $formLogin); });
  
  function modalAnimate ($oldForm, $newForm) {
    $('.alert-messages').html('');
    var $oldH = $oldForm.height();
    var $newH = $newForm.height();
    $divForms.css('height',$oldH);
    $oldForm.fadeToggle($modalAnimateTime, function(){
        $divForms.animate({height: $newH}, $modalAnimateTime, function(){
          $newForm.fadeToggle($modalAnimateTime);
        });
    });
  }
});
