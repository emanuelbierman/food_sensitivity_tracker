class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :destroy]

  def index
    @user_foods = Food.foods_by_days_count(current_user.id)
    render 'index'
  end

  def show
    if @food
      @food_days = @food.days
      render 'show'
    elsif @food.errors.any?
      flash[:alert] = []
      redirect_to user_path(current_user), alert: @food.errors.full_messages
    end
  end

  def destroy
    if @food
      @food.destroy
      redirect_to user_path(current_user), notice: "Your food has been deleted."
    end
  end

  private
    def set_food
      @food = Food.find_by(id: params[:id])
    end
end
