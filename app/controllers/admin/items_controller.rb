class Admin::ItemsController < ApplicationController
  include Admin::ItemsHelper

  before_action :authorize

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    add_image(params[:item][:images])
    add_categories(params[:item][:categories])
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :unit_price,
                                 :active, :image_id)
  end
end
