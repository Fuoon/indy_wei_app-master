class HomePageController < ApplicationController
  def home
  	# paginate(page: params[:page], :per_page => 15)
	@articles = Article.paginate(page: params[:page], :per_page => 10)
	@articles_strip = @articles[0..4]
  end
end
