class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.all
  end

  def edit
    if params[:id].to_i == current_user.id
      @user = User.find(params[:id])
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'User was successfully updated.'
      redirect_to user_path(@user.id)
    else
      flash[:alert] = 'User was error updated.'
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
