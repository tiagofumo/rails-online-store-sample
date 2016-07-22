$(document).on('page:change', function() {
  $('.add_to_cart').click(function() {
    $.post('/cart', {
      product_id: $(this).data('id'),
      quantity: $('#product_qty').val() || 1
    }).done(function(json) {
      $('.shopping-cart__count').text(json.cart_quantity);
    });
  });
});
