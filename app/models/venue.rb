class Venue < ActiveRecord::Base
  validates :name, :location, presence: true
end
