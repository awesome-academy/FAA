$(document).ready(function() {
  $('#recruitment_search').on('keyup',function() {
    var recruitment_search = $(this).val();
    data = {content_cont: recruitment_search}
    $.get($(this).attr('action'), data, null, 'script');
  });
});
