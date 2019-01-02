class FoodsController < ApplicationController

  before_action :set_user
  before_action :set_food, only: [:show]

  def index
    if @user
      @user_foods = @user.foods.food_count
      render 'index'
    elsif !@user.nil? && @user.errors.any?
      @errors = @user.errors.messages
      redirect_to root_path(errors: @errors)
    else
      redirect_to root_path
    end
  end

  # def new
  #   @food = Food.new
  # end

  def create
    if @user
      @food = Food.create(food_params)
      if @food.valid?
        @day = current_day(@user.id)
        @day.foods << @food
        @day.save
        session[:user_id] = @user.id
        @errors = "Your food has been added."
        redirect_to user_path(@user)
      elsif !@food.nil? && @food.errors.any?
        @errors = @food.errors.messages
        redirect_to user_path(@user, errors: @errors)
      else
        redirect_to root_path
      end
    elsif !@user.nil? && @user.errors.any?
      @errors = @user.errors.messages
      redirect_to root_path(errors: @errors)
    else
      redirect_to root_path
    end
  end

  def show
    if @user
      if @food.valid?
        @food_days = @food.days
        session[:user_id] = @user.id
        render 'show'
      else
        @errors = @food.errors
        redirect_to user_path(@user)
      end
    elsif !@user.nil? && @user.errors.any?
      @errors = @user.errors.messages
      redirect_to root_path(errors: @errors)
    else
      redirect_to root_path
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
      @food = Food.find(params[:id])
    end
end
