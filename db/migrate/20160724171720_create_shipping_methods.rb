class CreateShippingMethods < ActiveRecord::Migration
  def change
    create_table :shipping_methods do |t|
      t.string :name
      t.decimal :base_cost
      t.decimal :extra_cost_per_gram
      t.integer :base_cost_max_weight
      t.integer :delivery_time_min
      t.integer :delivery_time_max

      t.timestamps null: false
    end
  end
end
