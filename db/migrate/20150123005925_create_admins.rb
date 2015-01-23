class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.string :display_name

      t.timestamps null: false
    end
  end
end
