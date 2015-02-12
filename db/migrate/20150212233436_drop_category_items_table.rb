class DropCategoryItemsTable < ActiveRecord::Migration
  def up
    drop_table :category_items
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
