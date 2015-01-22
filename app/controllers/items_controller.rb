class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    Category.find(params[:id]).
            update_attributes(title: params[:item][:title],
                              description: params[:item][:description],
                              unit_price: params[:item][:unit_price],
                              active: params[:item][:active],
                              image_id: params[:item][:image_id])
  end

  def new
    @item = Item.new(title: params[:title],
                     description: params[:description],
                     unit_price: params[:unit_price],
                     active: params[:active],
                     image_id: params[:item][:image_id])
  end

  def create
    Item.create(title: params[:item][:title],
                              description: params[:item][:description],
                              unit_price: params[:item][:unit_price],
                              active: params[:item][:active],
                              image_id: params[:item][:image_id])
  end
end
