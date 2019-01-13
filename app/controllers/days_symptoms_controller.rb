class DaysSymptomsController < ApplicationController
  before_action :set_symptom

  def create
    comments = params[:days_symptom][:comments]
    if @symptom.valid?
      @symptom.save
      @day = current_day(current_user.id)
      @days_symptom = DaysSymptom.create(day_id: @day.id, symptom_id: @symptom.id, comments: comments)
      if @days_symptom.valid?
        @days_symptom.save
        @day.update(comments: @days_symptom.comments) if comments
        redirect_to user_path(current_user), notice: "Your symptom has been entered."
      elsif @days_symptom.errors.any?
        flash[:alert] = []
        redirect_to user_path(current_user), alert: @days_symptom.errors.full_messages
      end
    elsif @symptom.errors.any?
      flash[:alert] = []
      redirect_to user_path(current_user), alert: @food.errors.full_messages
    end
  end

private
  def set_symptom
    frequency = params[:days_symptom][:symptoms][:frequency]
    if !params[:days_symptom][:symptom_id].blank?
      symptom = Symptom.find_by(id: params[:days_symptom][:symptom_id])
      @symptom = Symptom.create(description: symptom.description, frequency: frequency)
    elsif params[:days_symptom][:symptoms][:description]
      description = params[:days_symptom][:symptoms][:description]
      @symptom = Symptom.create(description: description, frequency: frequency)
    end
  end

  def days_symptom_params
    params.require(:days_symptom).permit(
      :comments,
      :symptom_id,
      symptoms: [:description, :frequency]
    )
  end
end
