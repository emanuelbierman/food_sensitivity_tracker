class SessionsController < ApplicationController

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

  def destroy
    if logged_in?
      session.destroy
      redirect_to root_path, notice: "You have been logged out."
    end
  end

end
