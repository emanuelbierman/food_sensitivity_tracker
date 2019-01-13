class DaysController < ApplicationController

  def index
    if @user
      @days = @user.days_descending
      render 'index'
    else
      redirect_to root_path
    end
  end
end
