class DaysSymptomsController < ApplicationController

  def create
    @symptom = DaysSymptom.create_symptom_from(days_symptom_params)
    if @symptom.valid?
      @symptom.save
      @day = current_day(current_user.id)
      comments = params[:days_symptom][:comments]
      @days_symptom = DaysSymptom.create(day_id: @day.id, symptom_id: @symptom.id, comments: comments)
      @days_symptom.update(comments: comments) if comments
      if @days_symptom.valid?
        @days_symptom.save
        @day.update(comments: @days_symptom.comments) if @days_symptom.comments
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
  def days_symptom_params
    params.require(:days_symptom).permit(
      :comments,
      :symptom_id,
      symptoms: [:description, :frequency]
    )
  end
end
