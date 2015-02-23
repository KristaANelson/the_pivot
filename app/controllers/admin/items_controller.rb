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
    @item = Item.new(item_params)
    add_image(params[:item][:images])
    add_categories(params[:item][:categories])
    @item.save
    redirect_to admin_items_path
  end

  def edit
    @item = Item.find_by(id: params[:id])
  end

  def update
    @item = Item.find_by(id: params[:id])
    @item.update(item_params)
    update_image(params[:item][:images])
    update_categories(params[:item][:categories])
    @item.save
    redirect_to admin_items_path
  end

  def void_item
    item = Item.find(params[:id])
    item.pending = true
    item.save
    redirect_to :back
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :unit_price,
                                 :active, :image_id)
  end
end
