class Seller::ItemsController < ApplicationController
  def edit
    @user = User.find_by(slug: params[:slug])
    @item = Item.find_by(id: params[:id])
  end

  def destroy
    @user = User.find_by(slug: params[:slug])
    item  = Item.find_by(id: params[:id])
    item.destroy
    redirect_to seller_dashboard_path(@user.slug)
  end

  def update
    @user = User.find_by(slug: params[:slug])
    @item = Item.find_by(id: params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to seller_dashboard_path(@user.slug)
    else
      flash[:errors] = @item.errors.full_messages.uniq.join("<br>")
      redirect_to edit_seller_item_path(@user.slug, @item.id)
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :unit_price, :event_id, :user_id,
                                 :delivery_method, :section, :row, :seat)
  end
end
