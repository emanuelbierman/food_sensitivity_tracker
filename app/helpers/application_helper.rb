module ApplicationHelper

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  #
  def logged_in?
    !!current_user
  end
  #
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
  #
  # def current_day
  #   if @user
  #     @day = Day.create(user_id: @user.id)
  #     @abc_day = Day.find_by(month_day_year: @day.month_day_year)
  #     if !@abc_day.nil? && @user.days.include?(@abc_day)
  #       @abc_day
  #     else
  #       @day
  #     end
  #   end
  # end
end
