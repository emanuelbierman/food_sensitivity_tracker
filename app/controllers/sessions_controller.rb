class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    
  end

  def destroy
    if session[:id]
      session.destroy
    end
  end
end
