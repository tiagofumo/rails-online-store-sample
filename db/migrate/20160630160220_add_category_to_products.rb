class AddCategoryToProducts < ActiveRecord::Migration
  def self.up
    add_reference :products, :category, index: true, foreign_key: true
    change_column :products, :category_id, :integer, null: false
  end

  def self.down
    remove_reference :products, :category, index: true, foreign_key: true
  end
end
