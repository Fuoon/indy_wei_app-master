class ArticleCommentsController < ApplicationController
  before_action :signed_in_user

  def new
    @article_comment = ArticleComment.new
  end

  def create
    @article = Article.find(params[:article_id])
  	@article_comment = current_user.article_comments.build(article_comment_params)
    @article_comments = @article.article_comments
    @article_comment.article_id = @article.id
    if @article_comment.save
      respond_to do |format|
        format.html { redirect_to @article }
        format.js
      end
    else
      @article_comments = []
      redirect_to @article
    end
  end

  def like
    @article = Article.find(params[:article_id])
    @article_comment = ArticleComment.find(params[:id])
    @article_comments = @article.article_comments
    if @article_comment.liked_by current_user
      respond_to do |format|
        format.html { redirect_to @article_comment.article }
        format.js
      end
    else
      redirect_to '/signin'
    end
  end

  def unlike
    @article = Article.find(params[:article_id])
    @article_comment = ArticleComment.find(params[:id])
    @article_comments = @article.article_comments
    if @article_comment.unliked_by current_user
      respond_to do |format|
        format.html { redirect_to @article_comment.article }
        format.js
      end
    else 
      redirect_to '/signin'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @article_comments = @article.article_comments
    ArticleComment.find(params[:id]).destroy
    respond_to do |format|
        format.html { redirect_to @article }
        format.js
    end
  end

  private

  def article_comment_params
  	params.require(:article_comment).permit(:content)
  end
end