class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
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
