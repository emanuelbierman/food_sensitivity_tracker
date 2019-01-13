class SymptomsController < ApplicationController
  before_action :set_symptom, only: [:show, :destroy]

  def show
    if @symptom
      @symptom_days = @symptom.days
      render 'show'
    else
      redirect_back(fallback_location: user_path(current_user), alert: "Your symptom was not found.")
    end
  end

  def destroy
    if @symptom
      @symptom.destroy
      redirect_to user_path(current_user), notice: "Your symptom has been deleted."
    end
  end

  private
    def set_symptom
      @symptom = Symptom.find_by(id: params[:id])
    end
end
