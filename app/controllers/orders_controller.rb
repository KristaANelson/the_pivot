class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @order.items << Item.where(id: session[:cart])
  end

  def index
    if current_user
      @orders = Order.where(user_id: current_user.id)
    else
      redirect_to root_path
    end
  end

  def create
    if current_user
      @order = Order.create(user: current_user)
      cart_items_to_order_items
      send_emails
      flash[:success] = "Order confirmed! Please check your email!"
      redirect_to order_path(@order)
    else
      flash[:warning] = "Something went wrong. Please log in and try again"
      redirect_to root_path
    end
  end

  private

  cart_to_order_items
    @order.create_order_items(@cart)
    Item.mark_as_sold(@cart.cart_items)
    session[:cart] = []
    @cart.clear
  end

  send_emails
    UserMailer.purchase_confirmation(@order)
    @order.sellers.each do |seller|
      items = @order.items.where(user: seller)
      UserMailer.listing_sold_confirmation(seller, items)
    end
  end
end
