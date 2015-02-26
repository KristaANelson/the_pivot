class Seller::UsersController < ApplicationController
  def index
    @user = User.find_by(slug: params[:slug])
    if current_user.admin? || @user.slug == current_user.slug
      @items = @user.items
      @user_events = @items.active.group_by { |item| item.event }
      @sold_events = @items.sold.group_by { |item| item.event }
      @inactive_events = @items.inactive.group_by { |item| item.event }
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find_by(slug: params[:slug])
    @user_events = @user.group_events(session[:cart])
  end
end
