class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :destroy]

  def index
    @user_foods_grouped = Food.foods_by_days_count(current_user.id)
    render 'index'
  end

  def show
    if @food
      @food_days = @food.days
      render 'show'
    else
      redirect_to user_foods_path(current_user), alert: "Your food was not found."
    end
  end

  def destroy
    if @food
      @food.destroy
      # Do I need to destroy the associated DaysFood instance?
      redirect_to user_path(current_user), notice: "Your food has been deleted."
    end
  end

  private
    def set_food
      @food = Food.find_by(id: params[:id])
    end
end
