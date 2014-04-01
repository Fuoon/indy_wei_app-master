class GameCommentsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

	def new 
		@game_comment = GameComment.new
	end

	def create
		@game = Game.find(params[:game_id])
		@game_comment = current_user.game_comments.build(game_comment_params)
		@game_comment.game_id = @game.id
		@game_comments = @game.game_comments
		if @game_comment.save
			respond_to do |format|
	          format.html { redirect_to @game }
	          format.js
	        end 
		else
			@game_comment = []
			redirect_to @game
		end
	end

	def like
		@game = Game.find(params[:game_id])
		@game_comments = @game.game_comments
		@game_comment = GameComment.find(params[:id])
		if @game_comment.liked_by current_user
			respond_to do |format|
				format.html { redirect_to @game }
				format.js
			end
		else	
			redirect_to '/signin'
		end
	end

	def unlike
		@game = Game.find(params[:game_id])
		@game_comments = @game.game_comments
		@game_comment = GameComment.find(params[:id])
		@game_comment.unliked_by current_user
		respond_to do |format|
			format.html { redirect_to @game }
			format.js
		end
	end

	def destroy
		@game = Game.find(params[:game_id])
		@game_comments = @game.game_comments
		@game_comment = GameComment.find(params[:id]).destroy
		respond_to do |format|
          format.html { redirect_to @game }
          format.js
        end 
	end

	def edit
	    @game_comment = GameComment.find(params[:id])
	    @game = @game_comment.game
	  end

	  def update 
	    @game_comment = GameComment.find(params[:id])
	    if @game_comment.update_attributes(game_comment_params)
	        respond_to do |format|
	        	format.html { redirect_to @game_comment.game }
	        	format.js
	        end 
	    else
	        flash[:success] = "Unsuccessful edit"
	        redirect_to @game_comment.game
	    end
	  end

	private 

		def game_comment_params
			params.require(:game_comment).permit(:content)
		end
end
