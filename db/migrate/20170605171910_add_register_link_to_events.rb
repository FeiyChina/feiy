class AddRegisterLinkToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :register_link, :string
  end
end
