class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :address
      t.text :content

      t.timestamps
    end
  end
end
