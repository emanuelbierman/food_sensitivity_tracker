class FoodsController < ApplicationController

  before_action :set_user
  before_action :set_food, only: [:show, :destroy]

  def index
    if @user
      @user_foods = Food.foods_by_days_count(@user.id)
      render 'index'
    elsif !@user.nil? && @user.errors.any?
      @errors = @user.errors.messages
      redirect_to root_path(errors: @errors)
    else
      redirect_to root_path
    end
  end

  def create
    if @user
      @food = Food.create(food_params)
      if @food.valid?
        @day = current_day(@user.id)
        @day.foods << @food
        @day.save
        session[:user_id] = @user.id
        redirect_to user_path @user, notice: "Your food has been added."
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
      if @food
        @food_days = @food.days
        session[:user_id] = @user.id
        render 'show'
      else
        redirect_to user_path(@user)
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    if @user
      if @food
        @food.destroy
        redirect_to root_path, notice: "Food deleted."
      end
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
      @food = Food.find_by(id: params[:id])
    end
end
