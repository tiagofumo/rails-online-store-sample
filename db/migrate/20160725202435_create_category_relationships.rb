class CreateCategoryRelationships < ActiveRecord::Migration
  def change
    create_table :category_relationships do |t|
      t.integer :parent_id, index: true
      t.integer :child_id, index: true
    end
    add_foreign_key :category_relationships, :categories, column: :parent_id
    add_foreign_key :category_relationships, :categories, column: :child_id
    remove_column :categories, :category_id, index: true, foreign_key: true
  end
end
