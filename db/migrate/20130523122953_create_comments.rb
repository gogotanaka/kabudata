class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :sender
      t.string :contents
      t.integer :board_id

      t.timestamps
    end
  end
end
