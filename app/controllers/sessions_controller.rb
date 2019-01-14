class SessionsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_user

  def new
    if logged_in?
      redirect_to user_path(current_user)
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

  def create_from_facebook
    @user = User.new do |u|
      u.uid = auth['uid']
      u.name = auth['info']['name']
      u.image = auth['info']['image']
      u.email = auth['info']['email'] if auth['info']['email']
    end
    if @user.try(:name)
      @facebook_user = @user
      @user.username = @user.name
      render 'new'
    else
      flash[:alert] = "There was an error with logging in via Facebook."
      redirect_to root_path
    end
  end

  def destroy
    if logged_in?
      session.destroy
      redirect_to root_path, notice: "You have been logged out."
    end
  end

private

  def auth
    request.env['omniauth.auth']
  end
end
