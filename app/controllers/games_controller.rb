class GamesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index, :edit, :update, :uploaded_game]
  before_action :correct_user, only: :destroy
  
  def index
    @games = Game.all
  end

  def uploaded_games
    @games = current_user.games
  end

  def game
    @categories = Category.paginate(page: params[:page])
  end

  def new
  	@game = Game.new
  end

  def show
  	@game = Game.find(params[:id])
    # @category = Category.find(@game.category_id)
    # @status = Status.find(@game.status_id)
    @game_comments = @game.game_comments.paginate(page: params[:page])
  end

  def create 
    @game = current_user.games.build(game_params)
    @game.user = current_user
    if @game.save
      flash[:success] = "Game created"
      redirect_to root_url
    else
      flash[:success] = "Failed"
      redirect_to root_url
    end
  end

  def destroy
    @game.find(params[:id]).destroy
    flash[:success] = "Game deleted."
    redirect_to root_url
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(game_params)
      flash[:success] = "Game Updated"
      redirect_to @game
    else
      render 'edit'
    end
  end

  def upvote
    @game = Game.find(params[:id])
    @game.liked_by current_user
    flash[:success] = "like success"
    redirect_to @game 
  end

  def downvote
    @game = Game.find(params[:id])
    @game.downvote_from current_user
    flash[:success] = "dislike success"
    redirect_to @game
  end

  private

  def game_params
  	params.require(:game).permit(:name, :link, :description, :image, :category_id, :status_id)
  end

  def correct_user
  	@game = current_user.games.find_by(id: params[:id])
  	redirect_to root_url if @game.nil?
  end
end
