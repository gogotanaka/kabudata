class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :link
      t.string :newsdate
      t.string :word
      t.timestamps
    end
  end
end
