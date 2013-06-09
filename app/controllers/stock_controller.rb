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

    url = "http://kabu-sokuhou.com/brand/item/code___" + @stock.code.to_s
    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read, nil, 'utf-8')
    @yahoo = html.css("div#yahoo_item_block")[0].css("div.s_res").map{|x|
      [
        x.css("span.yahoo_title").inner_text,
        x.css("p.res_head")[0].inner_text.split(nil)[1],
        x.css("span")[1].inner_text,
        x.css("span")[2].inner_text,
        x.css("div.this_comment p")[0].to_html
      ]
    }

    url = URI.encode("http://t-proj.net/twitter/?q=" + @stock.name)
    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read)
    doc = html.css("div.twitter_status")
    @twitter = doc[2..doc.length-3].map{|x|
      [
        x.css("img")[0].to_html,
        x.inner_text.split("From")[0]
      ]
    }
    
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
