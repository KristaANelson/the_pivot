class UpdateItemPendingDefaultValue < ActiveRecord::Migration
  def change
    change_column :items, :pending, :boolean, :default => false
  end
end
