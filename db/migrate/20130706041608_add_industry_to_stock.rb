class AddIndustryToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :industry, :string
  end
end
