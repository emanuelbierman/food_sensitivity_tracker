class DaysController < ApplicationController

  before_action :set_day, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @days = Day.all
  end

  def new
    if @user
      render 'new'
    else
      redirect_to "signup"
    end
  end

  def create
    if @user
      @day = Day.new(day_params)
      @day.set_month_day_year
      unless abc_day.nil?
        @day = abc_day
      end
      if @day.valid?
        set_food
        set_symptoms
        redirect_to "/"
      else
        redirect_to "users/#{@user.id}/days/new"
      end
    else
      redirect_to "signup"
    end
  end

  def show
    if @user
      render 'show'
    else
      redirect_to "signup"
    end
  end

  def edit
    if @user
      render 'edit'
    else
      redirect_to "/days/#{@day.id}/edit"
    end
  end

  def update
  end

  def destroy
  end

  private
    def set_food
      @food = Food.find_or_create_by(food_params)
      @day.foods << @food if @food
      @day.save
    	@food.save
    end

    def set_symptoms
      @symptom = Symptom.find_or_create_by(symptom_params)
    	@day.symptoms << @symptom if @symptom
    	@day.save
    	@symptom.save
    end

    def abc_day
      # checks if a day instance has Already Been Created for that date
      Day.find_by(month_day_year: @day.month_day_year)
    end

    def set_user
      if session[:user_id]
        @user = User.find_by(id: session[:user_id])
      end
    end

    def set_day
      @day = Day.find(params[:id])
    end

    def food_params
      params.require(:food).permit(
        :name,
        :serving
      )
    end

    def symptom_params
      params.require(:symptom).permit(
        :description,
        :frequency
      )
    end

    def day_params
      params.require(:day).permit(
        :comments,
        :month_day_year
      )
    end
end
