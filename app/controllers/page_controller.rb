class PageController < ApplicationController
  def register_address
  	Mailaddress.create(address: params[:address])
  	redirect_to :back
  end

  def inquiry
  	
  end

  def rise
  	
  end
end
