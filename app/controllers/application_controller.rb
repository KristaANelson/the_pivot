class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    if session[:admin] && session[:admin] == true
      @current_user ||= Admin.find(session[:user_id]) if session[:user_id]
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
  helper_method :current_user

  def visitor
    find_admin || find_user
  end

  def redirect_after_login
    if session[:admin] == true
      redirect_to admin_path
    elsif session[:return_to]
      redirect_to session[:return_to]
    else
      redirect_to new_order_path
    end
  end

  private

  def set_cart
    @cart = Cart.new(session[:cart])
  end
  before_action :set_cart

  def authorize
    redirect_to root_path if current_user.nil? || !current_user.admin?
  end
  helper_method :authorize

  def find_admin
    Admin.find_by(email: params[:session][:email])
  end

  def find_user
    User.find_by(email: params[:session][:email])
  end
end
