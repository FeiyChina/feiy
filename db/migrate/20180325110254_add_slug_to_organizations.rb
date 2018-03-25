class AddSlugToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :slug, :string
  end
end
