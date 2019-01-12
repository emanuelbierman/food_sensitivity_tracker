class DaysFoodsController < ApplicationController
  before_action :set_food

  def create
    comments = params[:days_food][:comments]
    if @food.valid?
      @days_food = DaysFood.create(day_id: current_day.id, food_id: @food.id, comments: comments)
      redirect_to user_path(current_user)
    elsif @user.errors.any?
      flash[:alert] = []
      @user.errors.full_messages.each {|message| flash[:alert] << message }
      redirect_to root_path
    end
  end

  def update
    @days_food = DaysFood.find_by(id: params[:id])
  end

private
  def set_food
    serving = params[:days_food][:foods][:serving]
    if params[:days_food][:food_id]
      food = Food.find_by(id: params[:days_food][:food_id])
      @food = Food.create(name: food.name, serving: serving)
    elsif params[:days_food][:foods][:name]
      name = params[:days_food][:foods][:name]
      @food = Food.create(name: name, serving: serving)
    end
  end

  def days_food_params
    params.require(:days_food).permit(
      :comments,
      :food_id,
      foods: [:name, :serving],
      :symptom_id,
      symptoms: [:description, :frequency]
    )
  end
end
