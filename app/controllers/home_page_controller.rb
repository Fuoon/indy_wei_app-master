class HomePageController < ApplicationController
  def home
  	# paginate(page: params[:page], :per_page => 15)
	@articles = Article.all
	@articles_strip = @articles[0..4]
	@articles_list = @articles.paginate(page: params[:page], :per_page => 10)
  end
end
