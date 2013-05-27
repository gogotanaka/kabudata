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

  def register_address
  	Mailaddress.create(address: params[:address])
  	redirect_to :back
  end

  def show
    @stocks = Stock.all[0..30]
    @bar = "bar_" + params[:id] + ".jpg"
  end

  

  private 
  def scrape_stock_info(html, index)
      get_content(html, "dd", "ymuiEditLink mar0", index, "/strong").delete(",")
  end
end
