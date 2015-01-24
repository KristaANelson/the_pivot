class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.create(user_id: params[:user_id])
    redirect_to order_path(@order)
  end
end
