class AddCategoryToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :category, :string
  end
end
