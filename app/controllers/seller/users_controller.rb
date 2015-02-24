class Seller::UsersController < ApplicationController
  def index
    @user = User.find_by(slug: params[:slug])
    if @user.slug == current_user.slug || current_user.admin?
      @user_events = @user.group_events
      @items = @user.items
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find_by(slug: params[:slug])
    @items = @user.items.active.not_in_cart(session[:cart])
    @user_events = @user.group_events
  end
end
