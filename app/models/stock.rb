class Stock < ActiveRecord::Base
  attr_accessible :code, :high, :low, :market, :name, :opening, :previousprice, :previousvolume, :price, :volume, :chart
end
