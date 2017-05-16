$(document).ready(function() {
  $('.datetimepicker').datepicker({
    dateFormat: 'dd-mm-yy'
  });

  $('#course_search').on('keyup',function() {
    var course_search = $(this).val();
    var training_id = $('#training_id').val();
    var data = {course_search: course_search, training_id: training_id};
    $.get('./courses', data, null, 'script');
  });

  $('.course_image_slide').carousel();

  $('#education_training_name').addClass('education-training-name');
  $('#education_training_description').addClass('education-training-description');

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $(input).parent().siblings('.img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $(document).on('change', 'input[type=file]', {}, function(e){
    _this = e.target
    img_prev = $(_this).parent().siblings('.img_prev');
    $(img_prev).removeClass('hidden');
    image = $(_this).parent().siblings('.current-img');
    $(image).addClass('hidden');
    readURL(_this);
  })
});
