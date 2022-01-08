class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    # @posts = @user.posts.page(params[:page]).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user

  end

  def index
    @user = User.find(params[:id])
    @users = User.all
    # @user = User.find(current_user.id)
    # @users = User.where.not(id: current_user.id)
    @book = Book.new
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  # def followers
  #   user = User.find(params[:id])
  #   @users = user.followers
  # end

  # def followeds
  #   user = User.find(params[:id])
  #   @users = user.followeds
  # end
  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
