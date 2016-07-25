class Product < ActiveRecord::Base
  has_many :order_items
  has_many :product_pictures
  has_one  :primary_picture, -> { where(default: true) },
           class_name: 'ProductPicture'
end
