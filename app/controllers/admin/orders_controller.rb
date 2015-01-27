class Admin::OrdersController < ApplicationController
  def filter
    if params[:status] == "all"
      @orders = Order.all
    else
      @orders = Order.where("status = ?", params[:status])
    end
    redirect_to admin_path(status: params[:status])
  end
end
