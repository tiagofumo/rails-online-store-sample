class AddSparkfunIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :sparkfun_id, :integer
  end
end
