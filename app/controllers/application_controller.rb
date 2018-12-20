class ApplicationController < ActionController::Base

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  # def set_day
  #   if params[:id]
  #     @day = Day.find_by(id: params[:id])
  #   else
  #     @day = Day.new
  #   end
  #   unless abc_day.nil?
  #     @day = abc_day
  #   end
  # end

  def current_day(user_id)
    Day.find_or_create_by(date: Time.now.strftime("%d").to_i, month_day_year: Time.now.strftime("%m-%d-%y"), day_of_week: Time.now.strftime("%A"), user_id: user_id)
  end
end
