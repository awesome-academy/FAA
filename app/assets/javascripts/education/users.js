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
