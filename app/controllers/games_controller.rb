class GamesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :index, :edit, :update, :uploaded_game]
  before_action :correct_user, only: :destroy
  
  def index
    @games = Game.all

    @action_games = @games.where(:category_id => '1')
    @action_games_list = @action_games[0..4]

    @arcade_games = @games.where(:category_id => '2')
    @arcade_games_list = @arcade_games[0..4]

    @adventure_games = @games.where(:category_id => '3')
    @adventure_games_list = @adventure_games[0..4]

    @puzzle_games = @games.where(:category_id => '4')
    @puzzle_games_list = @puzzle_games[0..4]

    @rpg_games = @games.where(:category_id => '5')
    @rpg_games_list = @rpg_games[0..4]

    @shooter_games = @games.where(:category_id => '6')
    @shooter_games_list = @shooter_games[0..4]

    @strategy_games = @games.where(:category_id => '7')
    @strategy_games_list = @shooter_games[0..4]
  end

  def search
    @games = Game.search(params[:search])
  end

  def uploaded_games
    @games = current_user.games
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
      redirect_to @game
    else
      flash[:success] = "Failed"
      redirect_to games_path
    end
  end

  def destroy
    @game.find(params[:id]).destroy
    flash[:success] = "Game deleted."
    redirect_to games_path
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

  def like
    @game = Game.find(params[:id])
    @game.liked_by current_user
    flash[:success] = "like success"
    redirect_to @game 
  end

  def unlike
    @game = Game.find(params[:id])
    @game.unliked_by current_user
    flash[:success] = "unlike success"
    redirect_to @game
  end

  def dislike
    @game = Game.find(params[:id])
    @game.disliked_by current_user
    flash[:success] = "dislike success"
    redirect_to @game
  end

  def undislike
    @game = Game.find(params[:id])
    @game.undisliked_by current_user
    flash[:success] = "undislike success"
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
