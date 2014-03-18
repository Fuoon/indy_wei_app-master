class ArticleCommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def new
    @article_comment = Article_comment.new
  end

  def create
    @article = Article.find(params[:article_id])
  	@article_comment = current_user.article_comments.build(article_comment_params)
    @article_comment.article_id = @article.id
    if @article_comment.save
      flash[:success] = "Comment created!"
      redirect_to root_url
    else
      @article_comments = []
      flash[:unsuccess] = "Failed"
      redirect_to root_url
    end
  end

  def destroy
  end

  private

  def article_comment_params
  	params.require(:article_comment).permit(:content)
  end
end