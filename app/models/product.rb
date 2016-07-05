class Product < ActiveRecord::Base
  has_many :product_pictures

  def default_picture(type)
    product_pictures.select({ |p| p.default == true })[0].url(type)
  end
end
