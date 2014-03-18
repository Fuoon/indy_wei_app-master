class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @game = Game.find(params[:relationship][:game_id])
    current_user.follow!(@game)
    redirect_to @game
  end

  def destroy
    @game = Relationship.find(params[:id]).game
    current_user.unfollow!(@game)
    redirect_to :controller => 'games', :action => 'index'
  end
end