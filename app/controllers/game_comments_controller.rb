class GameCommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

	def new 
		@game_comment = Game_Comment.new
	end

	def create
		@game = Game.find(params[:game_id])
		@game_comment = current_user.game_comments.build(game_comment_params)
		@game_comment.game_id = @game.id
		if @game_comment.save
			flash[:success] = "Comment created"
			redirect_to @game
		else
			@game_comment = []
			flash[:unsuccess] = "Failed"
			redirect_to @game
		end
	end

	def like
		@game = Game.find(params[:game_id])
		@game_comment = Game_Comment.find(params[:id])
		@game_comment.liked_by current_user
		redirect_to @game
	end

	def unlike
		@game = Game.find(params[:game_id])
		@game_comment = Game_Comment.find(params[:id])
		@game_comment.unliked_by current_user
		redirect_to @game
	end

	def dislike
		@game = Game.find(params[:game_id])
		@game_comment = Game_Comment.find(params[:id])
		@game_comment.disliked_by current_user
		redirect_to @game
	end

	def undislike
		@game = Game.find(params[:game_id])
		@game_comment = Game_Comment.find(params[:id])
		@game_comment.undisliked_by current_user
		redirect_to @game
	end

	def destroy
		@game = Game.find(params[:game_id])
		@game_comment = Game_Comment.find(params[:id]).destroy
		redirect_to @game
	end

	def game_comment_params
		params.require(:game_comment).permit(:content)
	end
end
