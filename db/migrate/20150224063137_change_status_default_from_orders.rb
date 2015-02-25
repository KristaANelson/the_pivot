class ChangeStatusDefaultFromOrders < ActiveRecord::Migration
  def up
    change_column :orders, :status, :string, :default => "Ordered"
  end

  def down
    change_column :orders, :status, :string, :default => nil
  end
end
