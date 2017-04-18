class AddAddressToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :address, :string
  end
end
