class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @game = Game.find(params[:relationship][:game_id])
    current_user.follow!(@game)
    respond_to do |format|
      format.html { redirect_to @game }
      format.js
    end
  end

  def destroy
    @game = Relationship.find(params[:id]).game
    current_user.unfollow!(@game)
    respond_to do |format|
      format.html { redirect_to @game }
      format.js
    end
  end
end