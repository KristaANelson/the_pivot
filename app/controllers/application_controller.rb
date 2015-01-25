class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    if session[:admin]
      @current_user ||= Admin.find(session[:user_id]) if session[:user_id]
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

  helper_method :current_user

  private

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  before_action :set_cart
end
