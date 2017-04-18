class ChangeColumnsInOrganizations < ActiveRecord::Migration[5.0]
  def change
    change_column :organizations, :name, :string
    change_column :organizations, :problem, :string
    change_column :organizations, :description, :string
    change_column :organizations, :website, :string
  end
end
