class DaysFoodsController < ApplicationController

  def create
    binding.pry
    @food = DaysFood.create(days_food_params)
    if @food.valid?
      @food.save
      @day = current_day(current_user.id)
      comments = params[:days_food][:comments]
      @days_food = DaysFood.create(day_id: @day.id, food_id: @food.id, comments: comments)
      if @days_food.valid?
        @days_food.save
        # @day.update(comments: @days_food.comments) if @days_food.comments
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

private
  def days_food_params
    params.require(:days_food).permit(
      :food_id,
      days: [:comments],
      foods: [:name, :serving]
    )
  end
end
