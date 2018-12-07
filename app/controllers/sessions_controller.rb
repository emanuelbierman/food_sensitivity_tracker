class SessionsController < ApplicationController

  def new
    @user = User.new
    @errors = params[:errors] if params[:errors]
  end

  def create
    @user = User.find_or_create_by(name: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to "/"
    else
      @errors = @user.errors
      redirect_to "/signin"
    end
  end

  def destroy
    if session[:user_id]
      session.destroy
      @errors = "You have been logged out."
      redirect_to signin_path(errors: @errors)
    end
  end
end
