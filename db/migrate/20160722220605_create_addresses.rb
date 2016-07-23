class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :title, null: false
      t.string :receiver, null: false
      t.string :street, null: false
      t.binary :country, limit: 2, null: false
      t.string :city, null: false
      t.string :postal_code, null: false
      t.string :phone
      t.string :state
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
