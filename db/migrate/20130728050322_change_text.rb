class ChangeText < ActiveRecord::Migration
  def up
  end

  def down
  end
  def up
    change_column :comments, :contents, :text, :limit => nil
  end

  def down
    change_column :comments, :contents, :string
  end
end
