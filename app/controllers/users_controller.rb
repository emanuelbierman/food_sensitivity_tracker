class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create]
  skip_before_action :require_user

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Your account was successfully created."
    elsif @user.errors.any?
      flash[:alert] = []
      redirect_to root_path, alert: @user.errors.full_messages
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user == current_user
      session[:user_id] = @user.id
      @food = Food.new
      @days_food = DaysFood.new
      @symptom = Symptom.new
      @days_symptom = DaysSymptom.new
      @day = current_day(@user.id)
      render "show"
    else
      redirect_to user_path(current_user), alert: "You do not have permission to access this page."
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :username,
        :password
      )
    end
end
