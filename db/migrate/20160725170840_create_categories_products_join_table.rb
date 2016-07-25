class CreateCategoriesProductsJoinTable < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.references :category, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
    end
    remove_reference :products, :category, index: true, foreign_key: true
  end
end
