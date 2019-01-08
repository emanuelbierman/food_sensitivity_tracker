class SessionsController < ApplicationController

  before_action :set_messages

  def new
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      if @user
        redirect_to user_path(@user)
      else
        redirect_to root_path
      end
    else
      @user = User.new
      render 'new'
    end
  end

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end

  def destroy
    if session[:user_id]
      session.destroy
      redirect_to root_path, notice: "You have been logged out."
    end
  end

  private
    def set_messages
      @messages = []
    end
end
