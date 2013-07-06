class Stock < ActiveRecord::Base
  attr_accessible :code, :high, :low, :market, :name, :opening, :previousprice, :previousvolume, :price, :volume, :chart, :industry
  after_create :after_create_callback
  
  def after_create_callback
    Board.create(stock_id: self.id, title: self.name)
  end
  def self.convert(url)
    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    doc = Nokogiri::HTML(page.read, nil, 'utf-8')
  end
end
