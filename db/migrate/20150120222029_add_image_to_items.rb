class AddImageToItems < ActiveRecord::Migration
  def change
    add_reference :items, :image, index: true
    add_foreign_key :items, :images
  end
end
