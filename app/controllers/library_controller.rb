class LibraryController < ApplicationController
  def library
  	if signed_in?
  		@games = current_user.followings
  	end
  end
end
