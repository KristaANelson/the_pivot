class DropCategorizationsTable < ActiveRecord::Migration
  def up
    drop_table :categorizations
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
