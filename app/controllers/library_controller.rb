class LibraryController < ApplicationController
  def library
  	@games = current_user.followings
  end
end
