class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :create_admin, :delete_admin]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page], :per_page => 10)
  end

  def admin
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    redirect_to @user
  end

  def search
    @users = User.search(params[:search])
  end

  def show
  	@user = User.find(params[:id])
    @article_comments = @user.article_comments.paginate(page: params[:page], :per_page => 5)
    @game_comments = @user.game_comments.paginate(page: params[:page], :per_page => 5)
    @uploaded_games = @user.games 
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

  private

  	def user_params
  		params.require(:user).permit(:username, :email, :password, :password_confirmation, :image)
  	end

    # Before filters

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.admin?
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
