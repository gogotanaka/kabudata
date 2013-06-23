class AddRssToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :rss, :string
  end
end
