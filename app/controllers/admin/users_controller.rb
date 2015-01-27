class Admin::UsersController < ApplicationController
  before_action :authorize

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    puts @user.pretty_print_inspect
  end

end
