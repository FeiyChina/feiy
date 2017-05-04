class AddAcceptedToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :accepted?, :boolean, null: false, default: false
  end
end
