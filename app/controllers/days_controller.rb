class DaysController < ApplicationController

  before_action :set_user
  before_action :set_messages
  before_action :set_day, only: [:show, :update]
  before_action :set_food, only: [:update]
  before_action :set_symptom, only: [:update]


  def index
    if @user
      render 'index'
    elsif !@user.nil? && @user.errors.any?
      @user.errors.messages.each do |message|
        @messages << message
      end
      redirect_to root_path(messages: @messages)
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
      if @day
        render 'show'
      elsif !@day.nil? && @day.errors.any?
        @day.errors.messages.each do |message|
          @messages << message
        end
        redirect_to root_path(messages: @messages)
      end
    else
      redirect_to root_path
    end
  end

  def update
    if @user
      if @day
        @day.update(day_params)
        if @food || @symptom
          redirect_to user_path(@user)
        elsif !@food.nil? && @food.errors.any?
          @food.errors.messages.each {|message| @messages << message}
          redirect_to root_path(messages: @messages)
        elsif !@symptom.nil? && @symptom.errors.any?
          @symptom.errors.messages.each {|message| @messages << message}
          redirect_to root_path(messages: @messages)
        end
      elsif !@day.nil? && @day.errors.any?
        @day.errors.messages.each {|message| @messages << message}
        redirect_to root_path(messages: @messages)
    else
      redirect_to root_path
    end
  end

  private
    def set_messages
      @messages = []
    end

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
        if @food
          @day.foods << @food
          @day.save
          @food.save
          @message = "Your food has been created and added."
        elsif !@food.nil? && @food.errors.any?
          @message = @food.errors.messages
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
        if @symptom
          @day.symptoms << @symptom
          @day.save
          @symptom.save
          @errors = @symptom.errors if @symptom.errors
        end
      end
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
        food_attributes: [:name, :serving],
        symptom_ids: [],
        symptom_attributes: [:description, :frequency]
      )
    end
end
