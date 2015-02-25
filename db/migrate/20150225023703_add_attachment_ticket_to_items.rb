class AddAttachmentTicketToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :ticket
    end
  end

  def self.down
    remove_attachment :items, :ticket
  end
end
