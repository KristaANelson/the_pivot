class SessionsController < ApplicationController
  def new
  end

  def create
    if Admin.find_by(email: params[:session][:email])
      authenticate_admin(Admin.find_by(email: params[:session][:email]))
    else
      authenticate_user(User.find_by(email: params[:session][:email]))
    end
  end

  def destroy
    session.clear
    flash[:success] = "Successfully logged out!"
    redirect_to(:back)
  end

  private

  def authenticate_admin(admin)
    if Admin.find_by(email: params[:session][:email]).
        authenticate(params[:session][:password])
        session[:user_id] = admin.id
        session[:admin] = true
        redirect_to admin_path
    else
      flash[:errors] = "Invalid Login"
      redirect_to login_path
    end
  end

  def authenticate_user(user)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in!"
      redirect_to(:back)
    else
      flash[:errors] = "Invalid Login"
      render :new
    end
  end
end
