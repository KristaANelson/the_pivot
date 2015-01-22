class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    Category.find(params[:id]).
            update_attributes(name: params[:category][:name])
    redirect_to categories_path
  end
end
