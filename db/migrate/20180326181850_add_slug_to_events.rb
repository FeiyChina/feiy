class AddSlugToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :slug, :string
  end
end
