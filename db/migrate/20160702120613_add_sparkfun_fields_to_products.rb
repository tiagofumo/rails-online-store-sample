class AddSparkfunFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sku, :string
    add_column :products, :rosh, :boolean
    add_column :products, :open_source, :boolean
    add_column :products, :country, :string
    add_column :products, :pack_length, :integer
    add_column :products, :pack_width, :integer
    add_column :products, :pack_height, :integer
    add_column :products, :weight, :decimal
    add_column :products, :backorder_allowed, :boolean
  end
end
