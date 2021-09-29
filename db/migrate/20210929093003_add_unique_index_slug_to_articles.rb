class AddUniqueIndexSlugToArticles < ActiveRecord::Migration[5.2]
  def change
    add_index :articles, :slug, unique: true
  end
end
