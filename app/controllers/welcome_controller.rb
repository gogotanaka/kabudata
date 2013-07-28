require 'nokogiri'
require 'open-uri'
def get_content(html, tag, className, index, childPath=nil)
  html.search("//#{tag}[@class='#{className}']#{childPath}")[index].content    
end
class WelcomeController < ApplicationController
	def index
    @codes = Stock.convert("http://info.finance.yahoo.co.jp/ranking/?kd=56&mk=1").css("tr.rankingTabledata").map{|x| x.css("td")[1].content }[0..10]
    @summary = Summary.all
    @news = News.order("updated_at ASC")

    @up = Stock.convert("http://info.finance.yahoo.co.jp/ranking/?kd=1&mk=1&tm=d&vl=a").css("tbody tr").map{|x| [x.css("td")[0].inner_text, x.css("td")[1].inner_text, x.css("td")[3].inner_text,x.css("td")[5].inner_text,x.css("td")[7].inner_text,]}

    @down = Stock.convert("http://info.finance.yahoo.co.jp/ranking/?kd=2&mk=1&tm=d&vl=a").css("tbody tr").map{|x| [x.css("td")[0].inner_text, x.css("td")[1].inner_text, x.css("td")[3].inner_text,x.css("td")[5].inner_text,x.css("td")[7].inner_text,]}
  end

  def show
    @bar = "bar_" + params[:id] + ".jpg"
    @id = params[:id].to_i
    case @id
      
    when 1
      url = "http://info.finance.yahoo.co.jp/ranking/?kd=1&mk=1&tm=d&vl=a"
    when 2
      url = "http://info.finance.yahoo.co.jp/ranking/?kd=2&mk=1&tm=d&vl=a"
    when 3
      url = "http://info.finance.yahoo.co.jp/ranking/?kd=3&mk=1&tm=d&vl=a"
    when 4
      url = "http://info.finance.yahoo.co.jp/ranking/?kd=33&mk=1&tm=d&vl=a"
    when 5
      url = "http://info.finance.yahoo.co.jp/ranking/?kd=13&mk=1&tm=w&vl=a"
    when 6
      url = "http://info.finance.yahoo.co.jp/ranking/?kd=14&mk=1&tm=d&vl=a"
    when 7
      url = "http://info.finance.yahoo.co.jp/ranking/?kd=15&mk=1&tm=w&vl=a"
    when 8
      url = "http://info.finance.yahoo.co.jp/ranking/?kd=16&mk=1&tm=w&vl=a"
    end

    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read)
    @ths = html.css("table.rankingTable tr.rankingTablettl")[0].css("th")
    @impo = @ths.map do |x|
      unless x[:colspan].to_i == 1
        x[:colspan].to_i
      else
        1
      end
    end
    @ths = @ths.map{|x| x.text }
    @ths.delete_at(-1)
    @tds = html.css("tr.rankingTabledata").map{|x| x.css("td").map{|y| y.text} }
    @tds.each{|x| x.delete_at(-1)}
    if params[:id].to_i == 9
      html = Stock.convert("https://quick-v.nomura.co.jp/nomura/main/disp/Asp_Conts.asp?qid=03-05-01-01")
    end
  end

  private 
  def scrape_stock_info(html, index)
      get_content(html, "dd", "ymuiEditLink mar0", index, "/strong").delete(",")
  end
end
