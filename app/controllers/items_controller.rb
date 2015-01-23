class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.update(item_params)
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
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
