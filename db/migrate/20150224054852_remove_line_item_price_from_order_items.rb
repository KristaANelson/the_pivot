class RemoveLineItemPriceFromOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :line_item_price
  end
end
