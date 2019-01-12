class DaysSymptomsController < ApplicationController

  before_action :set_user
  before_action :set_days_symptom

  def update

  end

private
  def set_days_symptom
    @days_symptom = DaysSymptom.find_by(id: params[:id])
  end
end
