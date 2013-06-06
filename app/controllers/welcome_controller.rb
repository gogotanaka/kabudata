require 'nokogiri'
require 'open-uri'
def get_content(html, tag, className, index, childPath=nil)
  html.search("//#{tag}[@class='#{className}']#{childPath}")[index].content    
end
class WelcomeController < ApplicationController
	def index
		start = Time.now.strftime("%M").to_i
		
		@start = 3609
	  @ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
	  @stocks = Stock.all.sort_by {|x| x.price.gsub(/(\d{0,3}),(\d{3})/, '\1\2').to_i }
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
    @codes = Nokogiri::HTML(page.read).css("tr.rankingTabledata").map{|x| x.css("td")[1].content }
  end

  private 
  def scrape_stock_info(html, index)
      get_content(html, "dd", "ymuiEditLink mar0", index, "/strong").delete(",")
  end
end
