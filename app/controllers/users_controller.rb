class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to user_path(@user), notice: "Your account was successfully created."
    elsif @user.errors.any?
      flash[:alert] = []
      @user.errors.full_messages.each {|message| flash[:alert] << message }
      redirect_to root_path
    end
  end

  def show
    if @user
      if @user == current_user
        session[:user_id] = @user.id
        @food = Food.new
        @days_food = DaysFood.new
        @symptom = Symptom.new
        @days_symptom = DaysSymptom.new
        @day = current_day(@user.id)
        render "show"
      else
        redirect_to root_path, alert: "You must be signed in as #{current_user.username} to access this page"
      end
    else
      flash[:alert] = "You must be signed in to access this page"
      render "sessions/new"
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
