class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(display_name: params[:session][:display_name])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:errors] = "Invalid Login"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
