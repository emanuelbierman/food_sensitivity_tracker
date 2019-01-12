class DaysSymptomsController < ApplicationController
  before_action :set_symptom

  def create

  end

  def update

  end

private
  def days_symptom_params
    params.require(:days_food).permit(
      :comments,
      :symptom_id,
      symptoms: [:description, :frequency]
    )
  end
end
