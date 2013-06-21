class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.string :title
      t.text :contents

      t.timestamps
    end
  end
end
