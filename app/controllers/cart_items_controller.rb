class CartItemsController < ApplicationController
  def index
    @items = Item.where(id: @cart.cart_items)

  end

  def create
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.cart_items
    redirect_to request.referer
  end

  def destroy
    @cart.remove_item(params[:item_id])
    redirect_to cart_path
  end

  def update
    @cart.add_item(params[:item_id])
    session[:cart] = @cart.cart_items
    redirect_to cart_path
  end

  private

  def cart_params
    params.permit(:item_id)
  end
end
