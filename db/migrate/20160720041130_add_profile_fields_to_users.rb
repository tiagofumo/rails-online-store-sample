class AddProfileFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :text, limit: 250
    add_column :users, :alias, :string, limit: 50
    add_column :users, :country, :binary, limit: 2
  end
end
