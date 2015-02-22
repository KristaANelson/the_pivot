class SessionsController < ApplicationController
  def new
    if request.original_url != login_for_cart_url
      session[:return_to] ||= request.referer
    end
  end

  def create
    if visitor && visitor.authenticate(params[:session][:password]) && session[:forward_to]
      session[:user_id] = visitor.id
      session[:admin] = visitor.admin?
      flash[:success] = "Successfully logged in!"
      redirect_forward
    elsif visitor && visitor.authenticate(params[:session][:password])
      session[:user_id] = visitor.id
      session[:admin] = visitor.admin?
      flash[:success] = "Successfully logged in!"
      redirect_after_login
    else
      flash[:errors] = "Invalid Login"
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = "Successfully logged out!"
    redirect_to root_url
  end
end
