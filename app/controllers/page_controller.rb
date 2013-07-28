class PageController < ApplicationController
  def register_address
  	Mailaddress.create(address: params[:address])
  	redirect_to :back
  end

  def inquiry
    @inquiry = Inquiry.new
  end

  def inquiry_create
    @inquiry = Inquiry.create(params[:inquiry])
    redirect_to controller: :page, action: :have_inquiried
  end

  def rise
  	
  end

  def regulation
  end

  def piece
    @piece = Piece.find(params[:id])
  end

  def index
    @posts = Piece.all
  end

end
