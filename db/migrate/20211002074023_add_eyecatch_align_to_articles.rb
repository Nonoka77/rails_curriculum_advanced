class AddEyecatchAlignToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :eyecatch_align, :integer, default: 0, null: false
  end
end
