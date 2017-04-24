class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :content
      t.datetime :date
      t.string :venue
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
