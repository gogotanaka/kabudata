class StockController < ApplicationController
	def show
		@stock = Stock.find(params[:id])

		url = "http://kabu-sokuhou.com/brand/item/code___" + @stock.code.to_s
    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read, nil, 'utf-8')

    url = "http://stocks.finance.yahoo.co.jp/stocks/detail/?code=#{@stock.code}"
    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read, nil, 'utf-8')
    @doc = html.css("td.change")[0]
	end
end
