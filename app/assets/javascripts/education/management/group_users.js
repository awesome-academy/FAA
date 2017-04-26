$(document).ready(function(){

  $('.edu-group-tab-1').addClass('edu-group-active active');
  $('#edu-group-tab-1').addClass('edu-group-active active');
  $('.edu-group-tabs .edu-group-tab-links a').on('click', function(e)  {
    var currentAttrValue = $(this).attr('href')
    $('.edu-group-tabs ' + currentAttrValue).show().siblings().hide()
    $(this).parent('li').addClass('edu-group-active').siblings().removeClass('edu-group-active')
    $(currentAttrValue).addClass('active');
    $(currentAttrValue).siblings('.active').removeClass('active')
    const data = {added_users_search: '', group: $(this).attr('group')}
    $.get("/education/management/group_users/", data, null, 'script')
    e.preventDefault();
  });

  $(document).on('change', 'input[type=checkbox].select-all', {}, function(){
    const select_all_select = $(this)
    const inputs = $(select_all_select).parent('th').parent('tr')
      .parent('tbody').find('td.education-group-users-w4 input[type=checkbox]')
    inputs.each(function(){
      $(this).prop('checked', $(select_all_select).is(':checked'))
    })
  })

  $(document).on('click', '.btn-add-user', {}, function(){
    const group = $(this).attr('group')
    const  data = {user_search: '', group: group}
    $.get("/education/management/group_users/", data, null, 'script');
    $('.modal[group='+group+']').modal('show')
  })

  $(document).on('click', '.btn-remove-user', {}, function(){
    const inputs = $(this).parents('.edu-group-tab').find('table tbody tr td input[type=checkbox]:checked')
    const group = $(this).attr('group')
    var users = []
    $(inputs).each(function(){
      users.push({id: $(this).attr('user')})
    })
    if(users.length === 0){
      $.growl.error({message: I18n.t("education.management.group_users.at_least_one")})
      return false
    }
    const data = {users: users, group: group}
    $.ajax({
      type: 'DELETE',
      url: '/education/management/group_users',
      data: {education_management_users: JSON.stringify(data)}
    })
  })

  var checked_input = []
  $(document).on('change', '.modal input[type=checkbox]:unchecked', {}, function(){
    const user = $(this).attr('user')
    checked_input.splice(checked_input.indexOf(user),1)
  })

  $(document).on('change', '.modal input[type=checkbox]:checked', {}, function(){
    const user = $(this).attr('user')
    checked_input.push(user)
  })

  var added_checked_users = []
  $(document).on('change', '.added_users input[type=checkbox]:unchecked', {}, function(){
    const user = $(this).attr('user')
    added_checked_users.splice(added_checked_users.indexOf(user),1)
  })
  $(document).on('change', '.added_users input[type=checkbox]:checked', {}, function(){
    const user = $(this).attr('user')
    added_checked_users.push(user)
  })

  $('.group_user_search').on('keyup',function() {
    const modal = $(this).parents('.modal')[0]
    const group = $(modal).attr('group')
    const  user_search = $(this).val()
    const  data = {user_search: user_search, group: group, checked_input: checked_input}
    $.get("/education/management/group_users/", data, null, 'script');
    return false
  })

  $(document).on('click', '.modal-add-button', {}, function(){
    const modal = $(this).parents('.modal')[0]
    const group = $(modal).attr('group')
    var users = []
    $(modal).find('tbody tr td input[type=checkbox]:checked').each(function(){
      users.push({id: $(this).attr('user')})
    })
    const data = {users: users, group: group}
    if(users.length === 0){
      $.growl.error({message: I18n.t("education.management.group_users.at_least_one")})
      return false
    }
    $.ajax({
      type: 'POST',
      url: '/education/management/group_users',
      data: {education_management_users: JSON.stringify(data)}
    })
  })

  $(document).on('keyup', '.user-search', {}, function(){
    const added_users_search = $(this).val()
    const group = $(this).attr('group')
    const  data = {added_users_search: added_users_search, group: group, added_checked_users: added_checked_users}
    $.get("/education/management/group_users/", data, null, 'script')
    return false
  })

  $(document).on('click', 'tbody.unadded-user tr', {}, function(){
    const checkbox = $(this).find('td input')
    $(checkbox).prop('checked', !$(checkbox).prop('checked'))
    $(checkbox).trigger('change')
  })

  $(document).on('click', 'tbody.unadded-user tr td input', {}, function(event){
    event.stopPropagation()
  })
})
