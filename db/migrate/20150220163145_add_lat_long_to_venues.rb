class AddLatLongToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :lat, :float
    add_column :venues, :long, :float
    add_column :venues, :time_zone_offset, :integer
  end
end
