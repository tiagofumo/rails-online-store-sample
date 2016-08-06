module CartItemsHelper
  def cart_total(items)
    items.inject(0) { |sum, item| sum + item.quantity * item.product.price }
  end
end
