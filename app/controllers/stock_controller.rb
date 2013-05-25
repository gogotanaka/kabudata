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

   	url = html.css('div.to_yahoo_topic a')[0][:href]
    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read, nil, 'utf-8')
    @doc = html.css("ul.listStyleOpen")[0].content
	end
end
