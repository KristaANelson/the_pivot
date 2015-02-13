class AddDefaultValueToSold < ActiveRecord::Migration
  def up
    change_column :items, :sold, :boolean, :default => false
  end

  def down
    change_column :items, :sold, :boolean, :default => nil
  end
end
