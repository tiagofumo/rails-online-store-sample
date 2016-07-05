class Product < ActiveRecord::Base
  has_many :product_pictures

  def default_picture(type)
    product_pictures.first.url(type)
  end
end
