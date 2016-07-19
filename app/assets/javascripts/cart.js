$(document).on('page:change', function() {
  $('.delete_cart_item').click(function() {
    $.ajax({
      url: '/cart/'+$(this).data('id'),
      method: 'delete',
      dataType: 'json'
    }).done(function() {
      location.reload();
    });
  });
});
