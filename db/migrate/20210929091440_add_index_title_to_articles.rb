class AddIndexTitleToArticles < ActiveRecord::Migration[5.2]
  def change
    add_index :articles, :title, unique: true
  end
end
