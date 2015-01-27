class AdminController < ApplicationController
  before_action :authorize
  def index
    if params[:status].nil? || params[:status] == "all"
      @orders = all_orders
    else
      @orders = Order.where("status = ?", params[:status])
    end
  end

  def all_orders
    Order.all
  end
end
