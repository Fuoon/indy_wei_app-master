class ArticlesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :edit, :index, :update]
  before_action :correct_user,   only: :destroy

  def index
    @articles = Article.paginate(page: params[:page])
  end
  
  def search
    @articles = Article.search(params[:search])
  end

  def new
  	@article = Article.new
  end

  def show
  	@article = Article.find(params[:id])
    @article_comments = @article.article_comments.paginate(page: params[:page])
  end

  def create
  	@article = current_user.articles.build(article_params)
  	if @article.save
  		flash[:success] = "Article created!"
  		redirect_to @article
  	else
  		redirect_to 'articles/article'
  	end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Article deleted."
    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Edits Success"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

  	def article_params
  		params.require(:article).permit(:content, :title, :image)
  	end

  	def correct_user
  		@article = current_user.articles.find_by(id: params[:id])
  		redirect_to root_url if @article.nil?
  	end
end
