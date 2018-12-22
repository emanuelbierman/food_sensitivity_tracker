class DaysController < ApplicationController

  before_action :set_day, only: [:show, :update]
  before_action :set_user


  def index
    if @user
      render 'index'
    elsif !@user.nil? && @user.errors.any?
      @errors = @user.errors.messages
      redirect_to root_path(errors: @errors)
    else
      redirect_to root_path
    end
  end

  # def new
  #   if @user
  #     render 'new'
  #   else
  #     redirect_to "signup"
  #   end
  # end

  # def create
  #   if @user
  #     @day = Day.new(day_params)
  #     # @day.set_month_day_year
  #     unless abc_day.nil?
  #       @day = abc_day
  #     end
  #     if @day.valid?
  #       set_food
  #       set_symptoms
  #       redirect_to "/"
  #     else
  #       redirect_to "users/#{@user.id}/days/new"
  #     end
  #   else
  #     redirect_to "signup"
  #   end
  # end

  def show
    if @user
      if @day.valid?
        render 'show'
      else
        @errors = @day.errors
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def update
    if @user
      if @day.valid?
        @day.update(day_params)
        if @day.valid?
          # binding.pry
          if params[:day][:food_ids]
            set_food
            if @food.valid?
              redirect_to user_path(@user)
            else
              @errors = @food.errors
              redirect_to root_path
            end
          elsif params[:day][:food_attributes]
            set_food
            if @food.valid?
              redirect_to user_path(@user)
            else
              @errors = @food.errors
              redirect_to root_path
            end
          else
            redirect_to user_path(@user)
          end
        else
          @errors = @day.errors
          redirect_to root_path
        end
      else
        @errors = @day.errors
        redirect_to root_path
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

    def set_day
      if params[:id]
        @day = Day.find(params[:id])
      end
    end

    def set_food
      @food = Food.find(params[:day][:food_ids])
      @day.foods << @food if @food
      @day.save
    	@food.save
    end

    # def set_symptoms
    #   @symptom = Symptom.find_or_create_by(symptom_params)
    # 	@day.symptoms << @symptom if @symptom
    # 	@day.save
    # 	@symptom.save
    # end

    # def food_params
    #   params.require(:food).permit(
    #     :name,
    #     :serving
    #   )
    # end

    # def symptom_params
    #   params.require(:symptom).permit(
    #     :description,
    #     :frequency
    #   )
    # end

    def day_params
      params.require(:day).permit(
        :comments,
        :month_day_year,
        :day_of_week,
        food_ids: [],
        food_attributes: [:name, :serving]
      )
    end
end
