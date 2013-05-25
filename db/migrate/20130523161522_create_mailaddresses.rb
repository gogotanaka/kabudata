class CreateMailaddresses < ActiveRecord::Migration
  def change
    create_table :mailaddresses do |t|
      t.string :address

      t.timestamps
    end
  end
end
