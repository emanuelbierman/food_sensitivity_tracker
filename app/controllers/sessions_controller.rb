class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_by(name: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to "/"
    else
      redirect_to "signin"
    end
  end

  def destroy
    if session[:user_id]
      session.destroy
      redirect_to "signin"
    end
  end
end
