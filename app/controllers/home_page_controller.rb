class HomePageController < ApplicationController
  def home
	@articles = Article.paginate(page: params[:page])
  end
end
