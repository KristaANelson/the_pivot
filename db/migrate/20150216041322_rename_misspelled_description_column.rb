class RenameMisspelledDescriptionColumn < ActiveRecord::Migration
  def change
    rename_column :events, :desctiption, :description
  end
end
