class Order < ActiveRecord::Base
  has_many   :order_items
  belongs_to :user
  belongs_to :address
  belongs_to :shipping_method
  enum status: [:new_order, :picking, :packing, :shipped, :ready_for_pickup]

  def items
    order_items.length
  end

  def units
    order_items.inject(0) { |sum, i| sum + i.quantity }
  end

  def status_name
    names = {
      new_order: 'New Order',
      ready_for_pickup: 'Ready for Pickup',
    }
    names[status.to_sym] || status.capitalize
  end

  def subtotal
    order_items.inject(0) { |sum, i| sum + i.cost }
  end

  def shipping_cost
    shipping_method.cost order_items
  end

  def total_cost
    subtotal + shipping_cost
  end
end
