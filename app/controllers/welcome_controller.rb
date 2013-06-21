require 'nokogiri'
require 'open-uri'
def get_content(html, tag, className, index, childPath=nil)
  html.search("//#{tag}[@class='#{className}']#{childPath}")[index].content    
end
class WelcomeController < ApplicationController
	def index
    url = "http://info.finance.yahoo.co.jp/ranking/?kd=56&mk=1"

    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    @codes = Nokogiri::HTML(page.read).css("tr.rankingTabledata").map{|x| x.css("td")[1].content }[0..10]

    url = "http://news.finance.yahoo.co.jp/category/bus_all/"
    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read)
    @doc = html.css("div.ymuiContainer")[0].content
    @news = html.css("div.marB15").map{|x| ["http://news.finance.yahoo.co.jp" + x.css("a")[0][:href].to_s, x.css("a")[0].inner_text, x.css("li.ymuiDate").inner_text] }

    url = "http://finance.yahoo.co.jp"
    begin
      page = open(url)
    rescue OpenURI::HTTPError
      return
    end
    html = Nokogiri::HTML(page.read)
    x = html.css("div#slider")[0].css("dd")
    [1,2,3,4].each do |i|
      unless Summary.find_by_id(i)
        Summary.create(comparison: x[i*2].inner_text, price: x[i*2-1].inner_text)
      end
    end

    @summary = Summary.all
  end

  def show
    @bar = "bar_" + params[:id] + ".jpg"
    case params[:id].to_i
      
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
    

  end

  private 
  def scrape_stock_info(html, index)
      get_content(html, "dd", "ymuiEditLink mar0", index, "/strong").delete(",")
  end
end
