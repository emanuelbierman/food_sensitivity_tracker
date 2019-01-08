class SymptomsController < ApplicationController

  before_action :set_user
  before_action :set_symptom, only: [:show, :destroy]

  def create
    if @user
      @symptom = Symptom.create(symptom_params)
      if @symptom.valid?
        @day = current_day(@user.id)
        @day.symptoms << @symptom
        @day.save
        session[:user_id] = @user.id
        redirect_to user_path @user, notice: "Your symptom has been added."
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
      if @symptom
        @symptom_days = @symptom.days
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
      if @symptom
        @symptom.destroy
        redirect_to root_path, notice: "Symptom deleted."
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

    def symptom_params
      params.require(:symptom).permit(
        :description,
        :frequency
      )
    end

    def set_symptom
      @symptom = Symptom.find_by(id: params[:id])
    end
end
