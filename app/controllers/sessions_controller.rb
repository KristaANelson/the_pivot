class SessionsController < ApplicationController
  def new
    if params[:forward_to]
      session[:forward_to] = params[:forward_to]
    else
      session[:return_to] ||= request.referer
    end
  end

  def create
    if visitor && visitor.authenticate(params[:session][:password])
      if visitor.suspended?
        flash[:errors] = "Sorry, your account is suspended. \
                           Please contact site administrator."
        redirect_to root_url
      elsif visitor.activated?
        session[:user_id] = visitor.id
        session[:admin] = visitor.admin?
        flash[:success] = "Successfully logged in!"
        session[:forward_to] ? redirect_forward : redirect_after_login
      else
        flash[:warning] = "Account not activated. \
                           Check your email for the activation link."
        redirect_to root_url
      end
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
