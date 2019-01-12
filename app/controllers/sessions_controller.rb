class SessionsController < ApplicationController

  before_action :set_user, only: :new

  def new
    if logged_in?
      if @user && @user == current_user
        redirect_to user_path(@user), notice: "You have been logged in."
      else
        flash[:alert] = "Sorry, #{current_user.username}, you do not have access to that account."
        @user = User.new
        render 'new'
      end
    else
      @user = User.new
      render 'new'
    end
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user
      if @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user), notice: "You have been logged in."
      else
        flash[:alert] = "Your username and password did not match."
        render 'new'
      end
    else
      flash[:alert] = "Please enter a valid username, or else sign up as a new user."
      @user = User.new
      render 'new'
    end
  end

  def destroy
    if logged_in?
      session.destroy
      redirect_to root_path, notice: "You have been logged out."
    end
  end

private
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
