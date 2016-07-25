class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :status
      t.string :tracking_number
      t.references :user, index: true, foreign_key: true
      t.references :address, index: true, foreign_key: true
      t.references :shipping_method, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
