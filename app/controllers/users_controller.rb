class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.errors.any?
      user.errors.each do |field, message|
        flash["#{field}"] = "#{field}: #{message}"
      end
      redirect_to new_user_path
    else
      user.save
      session[:user_id] = user.id
      flash[:success] = "Account successfully created. You are logged in!"
      redirect_to session[:return_to]
    end
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
