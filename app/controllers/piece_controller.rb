class PieceController < ApplicationController
	def show
		@piece = Piece.find(params[:id])
	end
end
