class DaysFoodsController < ApplicationController

  def create
    binding.pry
    @days_food = DaysFood.new(days_food_params)
    if @days_food.save
      redirect_to user_path(current_user), notice: "Your food has been entered."
    else
      flash[:alert] = []
      redirect_to user_path(current_user), alert: @days_food.errors.full_messages
    end
  end

private
  def days_food_params
    params.require(:days_food).permit(
      :day_id,
      :food_attributes,
      :serving,
      :comments,
      :food_id
    )
  end
end
