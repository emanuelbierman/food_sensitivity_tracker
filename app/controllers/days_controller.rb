class DaysController < ApplicationController

  before_action :set_user
  before_action :set_day, only: [:show, :update]
  before_action :set_food, only: [:update]
  before_action :set_symptom, only: [:update]

  def index
    if @user
      @days = @user.days_descending
      render 'index'
    else
      redirect_to root_path
    end
  end

  def update
    if @user
      if @day
        @day.update(day_params)
        if @day.valid?
          if @food
            if @food.valid?
              @day.foods << @food
              @day.save
              @food.save
              redirect_to user_path(@user), notice: "Your food has been added."
            elsif @food.errors.any?
              messages = []
              @food.errors.messages.each {|message| messages << message}
              redirect_to root_path, alert: messages
            end
          elsif @symptom
            if @symptom.valid?
              @day.symptoms << @symptom
              @day.save
              @symptom.save
              redirect_to user_path(@user), notice: "Your symptom has been added."
            elsif @symptom.errors.any?
              messages = []
              @symptom.errors.messages.each {|message| messages << message}
              redirect_to root_path, alert: messages
            end
          end
        elsif @day.errors.any?
          messages = []
          @day.errors.messages.each {|message| messages << message}
          redirect_to root_path, alert: messages
        end
      else
        redirect_to user_path(@user), alert: "Please try again."
      end
    else
      redirect_to root_path, alert: "Please try logging in again."
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
        @day = Day.find_by(id: params[:id])
      end
    end

    def set_food
      if params[:day][:food_ids]
        food_id_is_present = !params[:day][:food_ids].blank?
        food_name_is_present = !params[:day][:foods_attributes]["0"][:name].blank?
        serving_is_present = !params[:day][:foods_attributes]["0"][:serving].blank?
        if food_id_is_present && serving_is_present
          serving = params[:day][:foods_attributes]["0"][:serving].to_i
          existing_food = Food.find_by(id: params[:day][:food_ids])
          @food = Food.create(name: existing_food.name, serving: serving)
        elsif food_name_is_present && serving_is_present
          serving = params[:day][:foods_attributes]["0"][:serving].to_i
          name = params[:day][:foods_attributes]["0"][:name]
          @food = Food.create(name: name, serving: serving)
        end
      end
    end

    def set_symptom
      if params[:day][:symptom_ids]
        symptom_id_is_present = !params[:day][:symptom_ids].blank?
        symptom_desc_is_present = !params[:day][:symptoms_attributes]["0"][:description].blank?
        frequency_is_present = !params[:day][:symptoms_attributes]["0"][:frequency].blank?
        if symptom_id_is_present && frequency_is_present
          frequency = params[:day][:symptoms_attributes]["0"][:frequency].to_i
          existing_symptom = Symptom.find_by(id: params[:day][:symptom_ids])
          @symptom = Symptom.create(description: existing_symptom.description, frequency: frequency)
        elsif symptom_desc_is_present && frequency_is_present
          frequency = params[:day][:symptoms_attributes]["0"][:frequency].to_i
          description = params[:day][:symptoms_attributes]["0"][:description]
          @symptom = Symptom.create(description: description, frequency: frequency)
        end
      end
    end

    def day_params
      params.require(:day).permit(
        :comments,
        :month_day_year,
        :day_of_week,
        food_ids: [],
        food_attributes: [:name, :serving],
        symptom_ids: [],
        symptom_attributes: [:description, :frequency]
      )
    end
end
