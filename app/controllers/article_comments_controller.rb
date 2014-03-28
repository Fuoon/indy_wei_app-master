class ArticleCommentsController < ApplicationController
  before_action :signed_in_user

  def new
    @article_comment = ArticleComment.new
  end

  def create
    @article = Article.find(params[:article_id])
  	@article_comment = current_user.article_comments.build(article_comment_params)
    @article_comment.article_id = @article.id
    if @article_comment.save
      redirect_to @article
    else
      @article_comments = []
      redirect_to @article
    end
  end

  def like
    @article_comment = ArticleComment.find(params[:id])
    @article_comment.liked_by current_user
    redirect_to @article_comment.article
  end

  def unlike
    @article_comment = ArticleComment.find(params[:id])
    @article_comment.unliked_by current_user
    redirect_to @article_comment.article
  end

  def destroy
    @article = Article.find(params[:article_id])
    ArticleComment.find(params[:id]).destroy
    redirect_to @article
  end

  private

  def article_comment_params
  	params.require(:article_comment).permit(:content)
  end
end