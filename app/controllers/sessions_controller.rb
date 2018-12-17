class SessionsController < ApplicationController

  def new
    if session[:user_id]
      @user = User.find(session[:user_id])
      redirect_to user_path(@user)
    else
      @user = User.new
      @errors = params[:errors] if params[:errors]
      render 'new'
    end
  end

  def create
    @user = User.find_or_create_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}"
    else
      @errors = @user.errors
      redirect_to root_path
    end
  end

  def destroy
    if session[:user_id]
      session.destroy
      @errors = "You have been logged out."
      redirect_to root_path(errors: @errors)
    end
  end
end
