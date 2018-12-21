class FoodsController < ApplicationController

  # set_food before_action @food = Food.find(params[:id])
  before_action :set_user
  before_action :set_food, only: [:show]

  def index
    if @user
      # all foods where food.day.user_id = @user.id, group by name, sort by food.days.count descending
      @user_foods = @user.foods.all
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
        # @each_day_after_food_days = []
        # @each_two_days_after_food_days = []
        # @food.days.each do |day|
        #   @food_days << day if day
        #   @each_day_after_food_days << day.next_day if day.next_day
        #   @each_two_days_after_food_days << day.two_days_later if day.two_days_later
        # end
        # binding.pry
        session[:user_id] = @user.id
        render 'show'
      else
        @errors = @food.errors
        redirect_to "/users/#{@user.id}"
      end
    else
      # @errors = @user.errors
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
