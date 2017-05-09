$(document).ready(function(){
  $('.edu-categories-search').on('keyup', '#q_name_cont', function() {
    $.get($('#q_name_cont').attr('action'),
      $('#q_name_cont').serialize(), null, 'script');
    return false;
  });

  $('#list_education_categories').on('click', '.edit-edu-category', function(){
    var category_id = this.dataset.id
    var category_type = this.dataset.selected
    var category_name = $('#edu-category-name-' + category_id).text()
    $('#edu-category-name-' + category_id).html(
      '<input value="'+category_name+'" class="sm-form-control input_education_category_name"' +
      'required="required" data-id="'+category_id+'" data-name="'+category_name+'"'+
      'type="text" name="education_category[name]">'
    )
    $('#edu-category-type-' + category_id).html(
      $('#category_types_select').html()
    )
    $('#edu-category-type-' + category_id).find('select').val(category_type)
  })

  $('#list_education_categories').on('keyup', '.input_education_category_name' ,function(e){
    if(e.which === 13) {
      var category_name = $(this).val()
      var category_id = this.dataset.id
      var category_type = $('#edu-category-type-' + category_id).find('select option:selected').text().toLowerCase()
      $.ajax({
        type: 'patch',
        url: '/education/management/categories/' + category_id,
        data: {
          education_category: {
            name: category_name,
            category_type: category_type
          }
        },
        success: function(data){
          if(data.status === 200) {
            $.growl.notice({title: '', message: data.flash})
            category = data.category
            $('#edu-category-name-' + category_id).html(category.name)
            $('#edu-category-type-' + category_id).html(category.category_type)
          }
          else {
            $.growl.error({title: '', message: data.flash});
            location.reload()
          }
        },
        error: function(error) {
          $.growl.error({title: '', message: error});
          location.reload();
        }
      });
    }
    if(e.which === 27) {
      var category_name = this.dataset.name;
      var category_id = this.dataset.id;
      $('#edu-category-name-' + category_id).html(category_name);
    }
  });

  $('#list_education_categories').on('click', '.delete-edu-category', function(){
    var category_id = this.dataset.id;
    if(confirm(I18n.t("education.javascripts.detete_category"))){
      $.ajax({
        type: 'delete',
        url: '/education/management/categories/' + category_id,
        success: function(data) {
          if(data.status === 200) {
            $.growl.notice({title: '', message: data.flash});
            $('#edu-category-' + category_id).remove();
          }
          else {
            $.growl.error({title: '', message: data.flash});
            location.reload();
          }
        },
        error: function(error) {
          console.log(error);
          $.growl.error({title: '', message: error});
        }
      });
    }
  });
});
