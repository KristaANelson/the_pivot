class ItemsController < ApplicationController
  def index
    @items = item.all
    @categories = category.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @user = current_user
    @events = Event.active
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to user_store_path(@item.seller)
    else
      render 'new'
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :unit_price, :event_id, :user_id,
                                 :delivery_method, :section, :row, :seat)
  end
end
