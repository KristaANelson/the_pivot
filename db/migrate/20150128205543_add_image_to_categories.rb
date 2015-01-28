class AddImageToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :image, index: true
    add_foreign_key :categories, :images
  end
end
