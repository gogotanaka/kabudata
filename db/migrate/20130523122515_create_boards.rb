class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :title
      t.integer :stock_id
      t.integer :consul
      t.string :image
      t.timestamps
    end
  end
end
