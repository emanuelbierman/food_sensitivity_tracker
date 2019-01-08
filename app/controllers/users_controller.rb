class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def show
    if @user
      session[:user_id] = @user.id
      @food = Food.new
      @symptom = Symptom.new
      @day = current_day(@user.id)
      render 'show'
    else
      redirect_to root_path
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :username,
        :password
      )
    end

    def set_user
      if session[:user_id]
        @user = User.find_by(id: session[:user_id])
      end
    end
end
