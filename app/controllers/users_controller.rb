class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user_id] = user.id
      flash[:success] = "Account successfully created. You are logged in!"
      redirect_to(session[:return_to]
    else
      redirect_to new_user_path
    end
  end


  # def create
  #   +    user = User.find_by(email: params[:session][:email])
  #   +    if user && user.authenticate(params[:session][:password])
  #     +      session[:user_id] = user.id
  #     +      flash[:success] = "Successfully logged in!"
  #     +      redirect_to(:back)
  #     +    else
  #     +      flash[:errors] = "Invalid Login"
  #     +      render :new
  #     +    end
  #    +  end
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
