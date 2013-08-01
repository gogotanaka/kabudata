class AdminController < ApplicationController
  http_basic_authenticate_with name: "tis1059", password: "tis1059"
	require 'xmlrpc/client'
	def board
		@boards = Board.where("stock_id IS NOT NULL")
	end

	def consul_board
		@boards = Board.where("stock_id IS NULL")
	end

	def blog
		@blogs = Blog.all
	end

	def stock
	end

	def mail
		@mail = Mailaddress.all
	end

	def inquiry
		@inquiry = Inquiry.all
	end

	def piece
		@piece = Piece.new
	end

	def create_piece
		Piece.create(params[:piece])
		redirect_to :back
	end
	def ping
		ping_servers = ["http://www.blogpeople.net/servlet/weblogUpdates",
			"http://blogsearch.google.co.jp/ping/RPC2",
			"http://blog.goo.ne.jp/XMLRPC",
			"http://ping.blogoon.net/",
			"http://ping.ask.jp/xmlrpc.m",
			"http://www.bloglines.com/ping",
			"http://api.my.yahoo.co.jp/RPC2",
			"http://ping.fc2.com/"]
    @response = []
    ping_servers.each do |ping_server|
      client = XMLRPC::Client.new2(ping_server)
      begin
      	client.http_header_extra = {"accept-encoding" => "identity"}   
        res = client.call("weblogUpdates.ping", 
           '仕手株急騰情報', 
           'http://tousijyohou.jp/page.atom')
        rescue Exception => e
        res = {"message" => "#{e.class}: #{e.message}", "flerror" => nil}
      end
      @response << [ping_server, res["message"]]
    end
    render :action => 'ping'
  end
end
