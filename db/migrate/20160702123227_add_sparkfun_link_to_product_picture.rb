class AddSparkfunLinkToProductPicture < ActiveRecord::Migration
  def change
    add_column :product_pictures, :default, :boolean
    add_column :product_pictures, :sparkfun_link, :string
  end
end
