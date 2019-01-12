class SymptomsController < ApplicationController

  before_action :set_user
  before_action :set_symptom, only: [:show, :destroy]

  def show
    if @user && logged_in?
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
        redirect_to root_path, notice: "Your symptom has been deleted."
      end
    else
      redirect_to root_path
    end
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
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
