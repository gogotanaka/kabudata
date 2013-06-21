class AdminController < ApplicationController

	def board
		@boards = Board.where("stock_id IS NOT NULL")
	end

	def consul_board
		@boards = Board.where("stock_id IS NULL")
	end

	def blog
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
end
