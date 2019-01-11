class ApplicationController < ActionController::Base

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def current_day(user_id)
    date = Time.now.strftime("%d")
    Day.find_or_create_by(date: date, user_id: user_id)
  end
end
