class PageController < ApplicationController
  def register_address
  	Mailaddress.create(address: params[:address])
  	redirect_to :back
  end

  def inquiry
    @inquiry = Inquiry.new
  end

  def inquiry_create
    @blog = Blog.create(params[:blog])
    redirect_to controller: :page, action: :have_inquiried
  end

  def rise
  	
  end
end
