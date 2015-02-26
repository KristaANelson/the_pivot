class UpdateTimeOnEvent < ActiveRecord::Migration
  def change
    rename_column :events, :time, :start_time
  end
end
