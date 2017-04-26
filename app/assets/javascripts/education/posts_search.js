$(document).ready(function() {
  $('#posts-search-txt').on('keyup',function(e) {
    var term = $(this).val();
    var data = {term: term};
    $.get('posts', data, null, 'script');
  });
});
