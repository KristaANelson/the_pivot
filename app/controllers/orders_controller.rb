class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def index
    if current_user
      @orders = Order.where("user_id = ?", current_user.id)
    else
      redirect_to root_path
    end
  end

  def create
    @order = Order.create(user_id:     params[:user_id],
                          status:      "ordered",
                          total_price: 0)
    create_order_items
    @order.update_attributes(total_price: order_total)
    redirect_to order_path(@order)
  end

  def create_order_items
    @cart.cart_items.each do |key, count|
      item = Item.find(key)
      OrderItem.create(order_id:        @order.id,
                       item_id:         item.id,
                       quantity:        count,
                       line_item_price: count * item.unit_price)
    end
  end

  def order_total
    @order.order_items.each.inject(0) { |sum, item| sum + item.line_item_price }
  end
end
