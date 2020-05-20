class UsersController < ApplicationController
  before_action :require_no_current_user!, only: [:new, :create]
  before_action :require_current_user!, only: [:index]

  def new
    @user = User.new
    render :new
  end

  def index
    @users = User.all
    render :index
  end


  def create
    @user = User.new(user_params)

    if !User.pass_valid?(params[:user][:password])
      flash[:errors] = ["Password must be at least 6 characters long"]
      render :new
    elsif User.find_by(username: params[:user][:username])
      flash[:errors] = ["Sorry, that username is taken, please try another"]
      render :new
    elsif @user.save
      login!(@user)
      flash[:notice] = ["Hello, #{ @user.username }, welcome to Tasker!"]
      redirect_to user_url(@user)
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
