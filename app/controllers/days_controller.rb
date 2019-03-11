class DaysController < ApplicationController

  def index
    if @user
      @days = @user.days_descending
      # binding.pry
      render 'index'
    else
      redirect_to root_path
    end
  end
end
