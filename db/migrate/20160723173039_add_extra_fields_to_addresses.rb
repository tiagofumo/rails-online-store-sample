class AddExtraFieldsToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :company, :string
    add_column :addresses, :street_extra, :string
  end
end
