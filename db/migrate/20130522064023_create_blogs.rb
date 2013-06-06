class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :url
      t.string :title
      t.string :describe
      t.integer :in, default: 0
      t.integer :out, default: 0
      t.integer :week_in, default: 0
      t.integer :month_in, default: 0
      t.string :image
      t.timestamps
    end
  end
end
