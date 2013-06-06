class StockController < ApplicationController
	def show
		@stock = Stock.find(params[:id])

    url = "http://stocks.finance.yahoo.co.jp/stocks/detail/?code=8411"
    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read, nil, 'utf-8')
    @doc = html.css("div.styleChart img")[0][:src]
	end

  def search
    words = params[:words].gsub(/　/," ").split(nil)
    @search_stocks = []
    words.each do |word|
      @search_stocks += Stock.where("name LIKE :word OR code LIKE :word", word: "%#{word}%")
    end
    @search_stocks.uniq!
  end
end
