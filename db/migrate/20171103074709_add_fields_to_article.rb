class AddFieldsToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :published_at, :datetime
    add_column :articles, :is_published, :boolean, default: false
    add_column :articles, :is_main_article, :boolean, default: false
  end
end
