class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.string :display_name
      t.integer :role

      t.timestamps null: false
    end
  end
end
