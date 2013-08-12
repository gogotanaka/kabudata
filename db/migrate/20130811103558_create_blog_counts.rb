class CreateBlogCounts < ActiveRecord::Migration
  def change
    create_table :blog_counts do |t|
      t.integer :blog_id
      t.integer :view

      t.timestamps
    end
  end
end
