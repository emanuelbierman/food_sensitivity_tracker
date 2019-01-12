class DaysFoodsController < ApplicationController
  before_action :set_food

  def create
    comments = params[:days_food][:comments]
    if @food.valid?
      @food.save
      @day = current_day(current_user.id)
      @days_food = DaysFood.create(day_id: @day.id, food_id: @food.id, comments: comments)
      if @days_food.valid?
        @days_food.save
        @day.update(comments: @days_food.comments) if comments
        redirect_to user_path(current_user), notice: "Your food has been entered."
      elsif @days_food.errors.any?
        flash[:alert] = []
        redirect_to user_path(current_user), alert: @days_food.errors.full_messages
      end
    elsif @food.errors.any?
      flash[:alert] = []
      redirect_to user_path(current_user), alert: @food.errors.full_messages
    end
  end

  def update
    @days_food = DaysFood.find_by(id: params[:id])
  end

private
  def set_food
    serving = params[:days_food][:foods][:serving]
    if !params[:days_food][:food_id].blank?
      food = Food.find_by(id: params[:days_food][:food_id])
      @food = Food.create(name: food.name, serving: serving)
    elsif params[:days_food][:foods][:name]
      name = params[:days_food][:foods][:name]
      @food = Food.create(name: name, serving: serving)
    end
  end

  def days_food_params
    params.require(:days_food).permit(
      :food_id,
      days: [:comments],
      foods: [:name, :serving]
    )
  end
end
