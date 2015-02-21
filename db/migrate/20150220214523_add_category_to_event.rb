class AddCategoryToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :category, index: true
    add_foreign_key :events, :categories
  end
end
