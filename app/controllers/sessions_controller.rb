class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    credentials = [params[:user][:username], params[:user][:password]]
    @user = User.find_by_credentials(*credentials)

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid credentials, please try again"]
      redirect_to new_session_url
    end

  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
