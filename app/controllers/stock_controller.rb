class StockController < ApplicationController
	def show
		@stock = Stock.find(params[:id])

    url = "http://106.187.54.79/stock/info/" + @stock.code.to_s
    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read, nil, 'utf-8')
    @yahoo = html.css("table td")[12].css("div.s_res")
    doc = html.css("table td")[11].css("div.twitter_status")
    @yahoo = @yahoo.map{|x|
      [
        x.css("span.yahoo_title").inner_text,
        x.css("p.res_head")[0].inner_text.split(nil)[1],
        x.css("span")[1].inner_text,
        x.css("span")[2].inner_text,
        x.css("div.this_comment p")[0].to_html
      ]
    }
    @twitter = (doc[2..doc.length-3]||[]).map{|x|
      [
        x.css("img")[0].to_html,
        x.inner_text.split("From")[0]
      ]
    }       
    url = URI.encode("http://t-proj.net/twitter/?q=" + @stock.name)
    @twitte = Stock.convert(url).css("div.twitter_status")
    
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
