class SymptomsController < ApplicationController

  # set_food before_action @food = Food.find(params[:id])
  before_action :set_user
  before_action :set_symptom, only: [:show]

  def index
    if @user
      # all symptoms where symptom.day.user_id = @user.id, group by name, sort by symptom.days.count descending
      @user_symptoms = @user.symptoms.all
      render 'index'
    elsif !@user.nil? && @user.errors.any?
      @errors = @user.errors.messages
      redirect_to root_path(errors: @errors)
    else
      redirect_to root_path
    end
  end

  # def new
  #   @symptom = Symptom.new
  # end

  def create
    if @user
      @symptom = Symptom.create(symptom_params)
      if @symptom.valid?
        @day = current_day(@user.id)
        @day.symptoms << @symptom
        @day.save
        session[:user_id] = @user.id
        @errors = "Your symptom has been added."
        redirect_to user_path(@user)
      elsif !@symptom.nil? && @symptom.errors.any?
        @errors = @symptom.errors.messages
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
      if @symptom.valid?
        @symptom_days = []
        @symptom_previous_days_each = []
        @symptom_two_days_ago_each = []
        @symptom.days.each do |day|
          @symptom_days << day if day
          @symptom_previous_days_each << day.previous_day if day.previous_day
          @symptom_two_days_ago_each << day.two_days_ago if day.two_days_ago
        end
        session[:user_id] = @user.id
        render 'show'
      else
        @errors = @symptom.errors
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

    def symptom_params
      params.require(:symptom).permit(
        :description,
        :frequency
      )
    end

    def set_symptom
      @symptom = Symptom.find(params[:id])
    end
end
