class Product < ActiveRecord::Base
  has_many :order_items
  has_many :product_pictures
  has_and_belongs_to_many :categories
  has_one  :primary_picture, -> { where(default: true) },
           class_name: 'ProductPicture'
end
