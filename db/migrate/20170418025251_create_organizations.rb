class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.references :user, foreign_key: true
      t.integer :name
      t.integer :problem
      t.integer :description
      t.integer :website

      t.timestamps
    end
  end
end
