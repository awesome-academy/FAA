$(document).ready(function(){
  $('.btn-technique-edit').on('click', function(){
    var id = $(this).data("id");
    $.ajax({
      url: '/education/management/techniques/' + id + '/edit' ,
      type:'GET',
      dataType: 'json',
      complete: function(xhr){
        var html_text = xhr.responseText;
        $('#show-edit-form').html(html_text);
        $('#edit-modal').modal('show');
        $('#myModalLabel').text(I18n.t("education.techniques.edit.edit_technique"));
      }
    })
  })
})

function showNewForm(){
  $.ajax({
    url: '/education/management/techniques/new',
    type:'GET',
    dataType: 'json',
    complete: function(xhr){
      var html_text = xhr.responseText;
      $('#show-edit-form').html(html_text);
      $('#edit-modal').modal('show');
      $('#myModalLabel').text(I18n.t("education.techniques.new.create_technique"));
    }
  });
}
