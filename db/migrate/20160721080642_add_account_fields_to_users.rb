class AddAccountFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company, :string
    add_column :users, :fax, :string
    add_column :users, :phone, :string
    add_column :users, :privacy_setting, :integer
  end
end
