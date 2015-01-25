class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:title,
                                 :description,
                                 :unit_price,
                                 :active,
                                 :image_id)
  end
end
