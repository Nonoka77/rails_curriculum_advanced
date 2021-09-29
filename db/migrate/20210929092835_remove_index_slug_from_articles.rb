class RemoveIndexSlugFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_index :articles, :slug
  end
end
