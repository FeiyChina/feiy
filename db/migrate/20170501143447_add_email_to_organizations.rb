class AddEmailToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :email, :string
  end
end
