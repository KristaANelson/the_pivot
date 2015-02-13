class AddDescriptionToEvent < ActiveRecord::Migration
  def change
    add_column :events, :desctiption, :text
  end
end
