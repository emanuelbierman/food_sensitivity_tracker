class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @errors = @user.errors
      redirect_to root_path(errors: @errors)
    end
  end

  def show
    if @user
      render 'show'
    else
      redirect_to root_path
    end
  end

  private
    def user_params
      params.require(:user).permit(
        :username,
        :password
      )
    end

    def set_user
      if session[:user_id]
        @user = User.find_by(id: session[:user_id])
      end
    end
    #
    # def set_food
    #   @food = Food.find_or_create_by(food_params)
    #   @day.foods << @food if @food
    #   @day.save
    # 	@food.save
    # end
    #
    # def set_symptoms
    #   @symptom = Symptom.find_or_create_by(symptom_params)
    # 	@day.symptoms << @symptom if @symptom
    # 	@day.save
    # 	@symptom.save
    # end
    #
    # def food_params
    #   params.require(:food).permit(
    #     :name,
    #     :serving
    #   )
    # end
    #
    # def symptom_params
    #   params.require(:symptom).permit(
    #     :description,
    #     :frequency
    #   )
    # end
    #
    # def day_params
    #   params.require(:day).permit(
    #     :comments,
    #     :month_day_year
    #   )
    # end
end
