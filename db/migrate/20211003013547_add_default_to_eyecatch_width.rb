class AddDefaultToEyecatchWidth < ActiveRecord::Migration[5.2]
  def up
    change_column :articles, :eyecatch_width, :integer, default: 100
  end

  def down
    change_column :articles, :eyecatch_width, :integer
  end
end
