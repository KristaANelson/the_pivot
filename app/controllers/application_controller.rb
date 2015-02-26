class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
  def current_user
    if session[:admin] && session[:admin] == true
      @current_user ||= Admin.find(session[:user_id]) if session[:user_id]
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
  helper_method :current_user

  def visitor
    if find_admin
      @cart = nil
    end
    find_admin || find_user
  end

  def redirect_after_login
    if session[:admin] == true
      redirect_to admin_path
    else
      redirect_to session[:return_to]
      session[:return_to] = nil
    end
  end

  def redirect_forward
    path = session[:forward_to]
    session[:forward_to] = nil
    if path == "orders_path"
      redirect_to seller_orders_path(current_user.slug)
    elsif path == "seller_store"
      redirect_to seller_store_path(current_user.slug)
    elsif path == "seller_dashboard"
      redirect_to seller_dashboard_path(current_user.slug)
    else
      redirect_to path
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
