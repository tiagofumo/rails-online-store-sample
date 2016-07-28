class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  def weight
    product.weight * quantity
  end

  def cost
    price * quantity
  end
end
