class UpdatePriceColumns < ActiveRecord::Migration
  def change
    rename_column :items, :price, :unit_price
    rename_column :order_items, :price, :line_item_price
    add_column :orders, :total_price, :integer
  end
end
