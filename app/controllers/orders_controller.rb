class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @items = Item.where(id: session[:cart])
  end

  def index
    if current_user
      @orders = Order.where("user_id = ?", current_user.id)
    else
      redirect_to root_path
    end
  end

  def create
    @order = Order.create(user_id:     current_user.id,
                          status:      "ordered")
    session[:cart] = []
    @cart.clear
    redirect_to order_path(@order)
  end
end
