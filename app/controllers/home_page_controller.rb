class HomePageController < ApplicationController
  def home
	@articles = Article.paginate(page: params[:page])
	@articles_strip = @articles[0..4]
	@articles_list = @articles[5..-1]
  end
end
