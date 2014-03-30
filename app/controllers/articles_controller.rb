class ArticlesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :edit, :index, :update]
  before_action :correct_user,   only: :destroy

  def index
    @articles = Article.paginate(page: params[:page], :per_page => 10)
  end
  
  def search
    @articles = Article.search(params[:search])
  end

  def new
  	@article = Article.new
    @image_attachment = @article.image_attachments.build
  end

  def show
  	@article = Article.find(params[:id])
    @image_attachments = @article.image_attachments.all
    @article_comments = @article.article_comments.paginate(page: params[:page], :per_page => 25)
    @articles = Article.all 
    @next_article = @articles[@articles.index(@article) + 1]
    @previous_article = @articles[@articles.index(@article) - 1]
  end

  def create
  	@article = current_user.articles.build(article_params)
  	if @article.save
      if params[:image_attachments] != nil
        params[:image_attachments]['image'].each do |a|
          @image_attachment = @article.image_attachments.create!(:image => a, :article_id => @article_id)
        end
      end
  		redirect_to @article
  	else
  		redirect_to 'articles/article'
  	end
  end

  def destroy
    Article.find(params[:id]).destroy
    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
    @image_attachments = @article.image_attachments.all
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      if params[:image_attachments] != nil
        params[:image_attachments]['image'].each do |a|
          @image_attachment = @article.image_attachments.create!(:image => a, :article_id => @article_id)
        end
      end
      redirect_to @article 
    else
      redirect_to @article
    end
  end

  private

  	def article_params
  		params.require(:article).permit(:content, :title, image_attachments_attributes: [:id, :article_id, :image])
  	end

  	def correct_user
  		@article = current_user.articles.find_by(id: params[:id])
  		redirect_to root_url if @article.nil?
  	end
end
