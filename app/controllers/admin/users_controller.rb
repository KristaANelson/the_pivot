class Admin::UsersController < ApplicationController
  before_action :authorize

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end
