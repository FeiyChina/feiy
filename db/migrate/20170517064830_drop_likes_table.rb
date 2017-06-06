class DropLikesTable < ActiveRecord::Migration[5.0]
  def up
    if ActiveRecord::Base.connection.data_source_exists? 'likes'
      drop_table :likes
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
