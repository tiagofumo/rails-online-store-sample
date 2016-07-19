$(document).on('ready page:change', function() {
  $('.category_arrow').click(function() {
    $(this).siblings('.category_list').toggle();
  });
});
