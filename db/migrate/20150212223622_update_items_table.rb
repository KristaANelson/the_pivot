class UpdateItemsTable < ActiveRecord::Migration
  def change
    remove_column :items, :title
    remove_column :items, :description
    remove_column :items, :image_id
    rename_column :items, :active, :pending
    add_column :items, :sold, :boolean, options: { default: false }
    add_column :items, :section, :string
    add_column :items, :row, :string
    add_column :items, :seat, :string
    add_column :items, :delivery_method, :string
    add_reference :items, :user, index: true
    add_reference :items, :event, index: true
  end
end
