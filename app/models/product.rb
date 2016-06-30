class Product < ActiveRecord::Base
  has_many :product_pictures

  def default_image
    'http://www.metalclayfindings.com/images/productimages/small/2800245.jpg'
  end
end
