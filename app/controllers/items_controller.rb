class ItemsController < ApplicationController
  def index
    @items = Item.all
    @categories = Category.all
  end

  def edit
    @category = Category.new(name: nil)
  end

end
