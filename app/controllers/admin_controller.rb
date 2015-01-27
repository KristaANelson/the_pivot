class AdminController < ApplicationController
  before_action :authorize
  def index
    if params[:status].nil? || params[:status] == "all"
      @orders = Order.all
    else
      @orders = Order.where("status = ?", params[:status])
    end
  end
end
