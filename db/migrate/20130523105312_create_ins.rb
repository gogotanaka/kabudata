class CreateIns < ActiveRecord::Migration
  def change
    create_table :ins do |t|
      t.integer :blog_id
      t.string :ip

      t.timestamps
    end
  end
end
