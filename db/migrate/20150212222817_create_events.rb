class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.boolean :approved
      t.references :image, index: true
      t.references :venue, index: true

      t.timestamps null: false
    end
    add_foreign_key :events, :images
    add_foreign_key :events, :venues
  end
end
