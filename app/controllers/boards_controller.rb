class BoardsController < ApplicationController

  def index
    @boards = Board.where("stock_id IS NOT NULL")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boards }
    end
  end

  def list
    @boards = Board.where("stock_id IS NOT NULL")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boards }
    end
  end

  def index_consul
    @boards = Board.where("stock_id IS NULL")
  end


  # GET /boards/1
  # GET /boards/1.json
  def show
    @board = Board.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @board }
    end
  end

  def new_consul
    @board = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @board }
    end
  end

  def new
    @board = Board.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @board }
    end
  end

  # GET /boards/1/edit
  def edit
    @board = Board.find(params[:id])
  end

  # POST /boards
  # POST /boards.json
  def create
    @board = Board.new(params[:board])

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: '掲示板が作成されました。１つ目の書き込みをして下さい' }
        format.json { render json: @board, status: :created, location: @board }
      else
        format.html { render action: "new" }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boards/1
  # PUT /boards/1.json
  def update
    @board = Board.find(params[:id])

    respond_to do |format|
      if @board.update_attributes(params[:board])
        format.html { redirect_to @board, notice: 'Board was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url }
      format.json { head :no_content }
    end
  end
  
  def post_comment
    Board.find(params[:id]).comments.create(params[:comment])
    redirect_to :back
  end

  def delete_comment
    Comment.find(params[:id]).destroy
    redirect_to :back
  end
end
