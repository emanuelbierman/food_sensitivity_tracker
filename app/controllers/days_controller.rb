class DaysController < ApplicationController

  before_action :set_day, only: [:show, :edit, :update, :destroy]
  # set_day before_action @day = Day.find(params[:id])

  def index
    @days = Day.all
  end

  def new
  end

  def create
    @day = Day.create(day_params)
    @day.set_m_d_y
    if @day.valid?
  end

  def show
  end

  def update
  end

  def destroy
  end

  private
    def set_day
      @day = Day.find(params[:id])
    end

    def day_params
      params.require(:day).permit(
        :comments,
        :month_day_year
      )
    end
end
