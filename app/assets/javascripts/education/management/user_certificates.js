$(document).ready(function(){
  $('.btn-add-certificates').click(function(){
    var id = $(this).data('trainer-id');
    $.ajax({
      url: '/education/management/user_certificates/' + id + '/edit',
      dataType: 'JSON',
      data: {
        id: id
      },
      success: function(xhr){
        var html_text = xhr.template;
        $('.certificate-edit-form').html(html_text);
        $('#certificate-edit-modal').modal('show');
      },
      error: function(error) {
        $.growl.error({message: error});
        location.reload();
      }
    })
  })
})
