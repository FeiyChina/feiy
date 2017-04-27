class AddRepresentativeToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :user_is_a_representative, :boolean, default: false
  end
end
