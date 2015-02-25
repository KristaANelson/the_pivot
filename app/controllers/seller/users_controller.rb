class Seller::UsersController < ApplicationController
  def index
    @user = User.find_by(slug: params[:slug])
    if current_user.admin? || @user.slug == current_user.slug
      @items = @user.items
      @user_events = @items.group_by { |item| item.event }
      @active_items = @items.active
      @sold_items = @items.sold
      @inactive_items = @items.inactive
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find_by(slug: params[:slug])
    # @items = @user.items.active.not_in_cart(session[:cart])
    @user_events = @user.group_events(session[:cart])
  end
end
