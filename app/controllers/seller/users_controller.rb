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
    @items = Item.active.available.where.not(id: session[:cart]).where(user_id: @user.id)
    @user_events = @user.group_events
  end
end
