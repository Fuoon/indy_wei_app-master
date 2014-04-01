class GamesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :edit, :update, :uploaded_games, :like, :unlike, :dislike, :undislike]
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

    @sport_games = @games.where(:category_id => '7')
    @sport_games_list = @sport_games[0..4]

    @strategy_games = @games.where(:category_id => '8')
    @strategy_games_list = @strategy_games[0..4]
  end

  def show_all_action_games
    @games = Game.all
    @action_games = @games.where(:category_id => '1')
  end

  def show_all_arcade_games
    @games = Game.all
    @arcade_games = @games.where(:category_id => '2')
  end

  def show_all_adventure_games
    @games = Game.all
    @adventure_games = @games.where(:category_id => '3')
  end

  def show_all_puzzle_games
    @games = Game.all
    @puzzle_games = @games.where(:category_id => '4')
  end

  def show_all_rpg_games
    @games = Game.all
    @rpg_games = @games.where(:category_id => '5')
  end

  def show_all_shooter_games
    @games = Game.all
    @shooter_games = @games.where(:category_id => '6')
  end

  def show_all_sport_games
    @games = Game.all
    @sport_games = @games.where(:category_id => '7')
  end

  def show_all_strategy_games
    @games = Game.all
    @strategy_games = @games.where(:category_id => '8')
  end

  def show_all_games
    @games = Game.paginate(page: params[:page], :per_page => 10)
  end

  def search
    @games = Game.search(params[:search])
  end

  def uploaded_games
    @games = current_user.games
  end

  def new
  	@game = Game.new
    @image_attachment = @game.image_attachments.build
  end

  def show
  	@game = Game.find(params[:id])
    @image_attachments = @game.image_attachments.all
    @category = Category.find(@game.category_id)
    @status = Status.find(@game.status_id)
    @game_comments = @game.game_comments.all
  end

  def follow_without_signed_in
    redirect_to '/signin'
  end

  def create 
    @game = current_user.games.build(game_params)
    @game.user = current_user
    if @game.save
      if params[:image_attachments] != nil
        params[:image_attachments]['image'].each do |a|
          @image_attachment = @game.image_attachments.create!(:image => a, :game_id => @game_id)
        end
        redirect_to @game
      else
        flash[:unsuccess] = "Unable to share a game, need to upload a photo"
        @game.destroy
        redirect_to new_game_path(@game)
      end
    else
      render 'new'
    end
  end

  def destroy
    @game = Game.find(params[:id])
    Game.find(params[:id]).destroy
    if current_user.admin?
      redirect_to show_all_games_path
    else
      redirect_to games_path 
    end
  end

  def edit
    @game = Game.find(params[:id])
    @image_attachments = @game.image_attachments.all
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(game_params)
      if params[:image_attachments] == nil && @game.image_attachments.count == 0
        flash[:unsuccess] = "Unable to edit a shared game, need to upload a photo"
        redirect_to edit_game_path(@game)
      else
        if params[:image_attachments] != nil
          params[:image_attachments]['image'].each do |a|
            @image_attachment = @game.image_attachments.create!(:image => a, :game_id => @game_id)
          end
        end
        redirect_to @game
      end
    else
      flash[:unsuccess] = "Not everything is filled"
      redirect_to edit_game_path(@game)
    end
  end

  def like
    @game = Game.find(params[:id])
    if @game.liked_by current_user
        respond_to do |format|
          format.html { redirect_to @game }
          format.js
        end 
    else
        redirect_to '/signin'
    end
  end

  def unlike
    @game = Game.find(params[:id])
    @game.unliked_by current_user
    respond_to do |format|
      format.html { redirect_to @game }
      format.js
    end 
  end

  def dislike
    @game = Game.find(params[:id])
    if @game.disliked_by current_user
        respond_to do |format|
          format.html { redirect_to @game }
          format.js
        end
    else
        redirect_to '/signin'
    end
  end

  def undislike
    @game = Game.find(params[:id])
    @game.undisliked_by current_user
    respond_to do |format|
      format.html { redirect_to @game }
      format.js
    end
  end

  private

  def game_params
  	params.require(:game).permit(:name, :link, :description, :category_id, :status_id, image_attachments_attributes: [:id, :article_or_game_id, :image])
  end

  def correct_user
  	@game = current_user.games.find_by(id: params[:id])
  	redirect_to root_url if @game.nil?
  end
end
