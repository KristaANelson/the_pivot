class CartItemsController < ApplicationController
  def index
  end

  def create
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.cart_items
    redirect_to menu_path
  end
end
