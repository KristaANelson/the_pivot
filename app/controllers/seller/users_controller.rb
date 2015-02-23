class Seller::UsersController < ApplicationController
  def index
    if current_user && current_user.admin? || current_user.slug == params[:slug]
      @user = User.find_by(slug: params[:slug])
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
