module ApplicationHelper
  def abc_day
    # has a day Already Been Created?
    Day.find_by(month_day_year: @day.month_day_year)
  end

  def set_day
    if params[:id]
      @day = Day.find_by(id: params[:id])
    else
      @day = Day.new
    end
    unless abc_day.nil?
      @day = abc_day
    end
  end

  def current_day
    @day = Day.new
    unless abc_day.nil?
      @day = abc_day
    end
    if @user
      unless @user.days.include?(@day)
        @user.days << @day
      end
    end
    @day
  end
end
