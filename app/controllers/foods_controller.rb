class FoodsController < ApplicationController

  # set_food before_action @food = Food.find(params[:id])

  def index
    @foods = Food.all
  end

  def new
  end

  def create

  end

  def show
    @food_days = @food.days
  end

end
