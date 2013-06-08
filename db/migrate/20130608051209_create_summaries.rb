class CreateSummaries < ActiveRecord::Migration
  def change
    create_table :summaries do |t|
      t.string :price
      t.string :comparison
      t.timestamps
    end
  end
end
