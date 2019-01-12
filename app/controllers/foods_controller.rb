class FoodsController < ApplicationController
  before_action :set_food, only: [:show, :destroy]

  def index
    @user_foods = Food.foods_by_days_count(@user.id)
    render 'index'
  end

  def show
    if @food
      @food_days = @food.days
      session[:user_id] = @user.id
      render 'show'
    else
      redirect_to user_path(@user)
    end
  end

  def destroy
    if @food
      @food.destroy
      redirect_to root_path, notice: "Your food has been deleted."
    end
  end

  private
    def set_food
      @food = Food.find_by(id: params[:id])
    end
end
