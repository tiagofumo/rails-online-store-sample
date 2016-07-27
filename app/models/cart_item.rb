class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  def weight
    product.weight * quantity
  end
end
