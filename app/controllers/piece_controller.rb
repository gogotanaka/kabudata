class PieceController < ApplicationController
	def show
		@piece = Piece.find(params[:id])
	end
  def destroy
    Piece.find(params[:id]).destroy
    redirect_to :back
  end
end
