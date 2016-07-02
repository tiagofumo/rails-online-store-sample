class FixRoshFieldInProducts < ActiveRecord::Migration
  def change
    remove_column :products, :rosh
    add_column :products, :rohs, :boolean
  end
end
