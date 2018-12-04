class FoodsController < ApplicationController

  # set_food before_action @food = Food.find(params[:id])
  before_action :set_user
  before_action :set_food, only: [:create, :show]

  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create

  end

  def show
    if @user
      set_food
      if @food.valid?
        @food_days = @food.days
        render 'show'
      else
        redirect_to "/"
      end
    else
      redirect_to "signup"
    end
  end

  private
    def set_user
      if session[:user_id]
        @user = User.find_by(id: session[:user_id])
      end
    end

    def food_params
      params.require(:food).permit(
        :name,
        :serving
      )
    end

    def set_food
      @food = Food.new(food_params)
    end
end
