class DaysSymptomsController < ApplicationController

  def create
    @days_symptom = DaysSymptom.new(days_symptom_params)
    if @days_symptom.save
      redirect_to user_path(current_user), notice: "Your symptom has been entered."
    else
      flash[:alert] = []
      redirect_to user_path(current_user), alert: @days_symptom.errors.full_messages
    end
  end

  def destroy
    @days_symptom = DaysSymptom.find_by(id: params[:id])
    @symptom = @days_symptom.symptom
    @days_symptom.destroy
    redirect_to user_path(current_user), notice: "You removed #{@symptom.description} from this day."
  end

private
  def days_symptom_params
    params.require(:days_symptom).permit(
      :day_id,
      :symptom_attributes,
      :frequency,
      :comments,
      :symptom_id
    )
  end
end
