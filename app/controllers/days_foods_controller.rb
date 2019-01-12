class DaysFoodsController < ApplicationController

  before_action :set_user
  before_action :set_days_food

  def update

  end

private
  def set_user
    @user = User.find_by(id: params[:id])
  end

  def set_days_food
    @days_food = DaysFood.find_by(id: params[:id])
  end
end
