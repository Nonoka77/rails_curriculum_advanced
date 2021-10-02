class AddEyecatchAlignToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :eyecatch_align, :integer
  end
end
