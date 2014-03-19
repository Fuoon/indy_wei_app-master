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

	def upvote
		@game = Game.find(params[:game_id])
		@game_comment = Game_Comment.find(params[:id])
		@game_comment.liked_by current_user
		redirect_to @game
	end

	def downvote
		@game = Game.find(params[:game_id])
		@game_comment = Game_Comment.find(params[:id])
		@game_comment.downvote_from current_user
		redirect_to @game
	end

	def destroy
	end

	def game_comment_params
		params.require(:game_comment).permit(:content)
	end
end
