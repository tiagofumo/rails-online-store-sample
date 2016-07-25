class Order < ActiveRecord::Base
  has_many   :order_items
  belongs_to :user
  belongs_to :address
  belongs_to :shipping_method
  enum status: [:new_order, :picking, :packing, :shipped, :ready_for_pickup]
end
