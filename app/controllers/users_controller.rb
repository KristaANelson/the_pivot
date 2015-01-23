class UsersController < ApplicationController
  def new
  @user = User.new
  end

  def create
    if User.find_by(email: params[:user][:email])
      #flash - email already exisits
    elsif User.find_by(display_name: params[:user][:email])
      #flash - display_name already exists
    else
      user = User.create(user_params)
      session[:user_id] = user.id
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :display_name, :email, :password, :password_confirmation)
  end

end
