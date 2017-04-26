//= require js/jquery.raty.js

$(document).ready(function () {
   $('.rated').raty({
    path: '/assets/education/rate',
    half: true,
    score: $('.rated').attr('score'),
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    readOnly: true
  });

  $('.guess-rate').raty({
    path: '/assets/education/rate',
    half: true,
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    click: function(score, evt) {
      window.location.href = '../../users/sign_in'
    }
  });

  $('.user-rate').raty({
    path: '/assets/education/rate',
    half: true,
    starOff: 'star-off.png',
    starOn: 'star-on.png',
    click: function(score, evt) {
      user_id = $('.user-rate').attr('user-id');
      rateable_id = $('.user-rate').attr('rateable-id');
      rateable_type = $('.user-rate').attr('rateable-type');
      $.ajax({
        method: 'post',
        url: rateable_id + '/rates/',
        data: {
          education_rate: {
            user_id: user_id,
            rate: score,
            rateable_type: rateable_type
          }
        },
        success: function(){
          $('.user-rate').raty('readOnly', true),
          title = I18n.t("education.rates.rate.thanks_title");
          flash = I18n.t("education.rates.rate.thanks");
          $.growl.notice({title: title, message: flash});
        }
      });
    }
  });
})
