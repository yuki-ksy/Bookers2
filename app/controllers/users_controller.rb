class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :user_check, only: [:edit, :update]
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user) ,notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end


def create
    @book = Book.new(book_params)
    @books = Book.all
    @user = current_user
    @book.user_id = current_user.id
    redirect_to book_path(@user), notice: 'Welcome! You have signed up successfully.'
end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def user_check
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user)
    end
  end

end
