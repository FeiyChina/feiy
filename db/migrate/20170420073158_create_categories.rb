class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :categorizable_id
      t.string :categorizable_type

      t.timestamps
    end
  end
end
