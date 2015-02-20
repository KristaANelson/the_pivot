class UsersController < ApplicationController
  def new
    if request.original_url != login_for_cart_url && request.original_url != new_user_url
      session[:return_to] ||= request.referer
    end
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.errors.any?
      user.errors.full_messages.each do |message|
        flash[message] = message
      end
      redirect_to new_user_path
    else
      session[:user_id] = user.id
      flash[:success] = "Account successfully created. You are logged in!"
      redirect_after_login
    end
  end

  def show
    @user = User.find_by(slug: params[:slug])
    @items = Item.active.available.where.not(id: session[:cart]).where(user_id: @user.id)
    @user_events = @user.group_events
  end

  private

  def user_params
    params.require(:user).permit(
      :full_name,
      :display_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
