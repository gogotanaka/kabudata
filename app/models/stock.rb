class Stock < ActiveRecord::Base
  attr_accessible :code, :high, :low, :market, :name, :opening, :previousprice, :previousvolume, :price, :volume, :chart
  after_create :after_create_callback
  
  def after_create_callback
    Board.create(stock_id: self.code, title: self.name)
  end
end
