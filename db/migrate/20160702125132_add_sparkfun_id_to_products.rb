class AddSparkfunIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sparkfun_id, :integer
  end
end
