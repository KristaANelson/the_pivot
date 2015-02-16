class Venue < ActiveRecord::Base
  validates :name, :location, presence: true
  has_many :events
end
