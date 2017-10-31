class DropCategoriesTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :categories if ActiveRecord::Base
                              .connection
                              .data_source_exists? 'categories'
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
