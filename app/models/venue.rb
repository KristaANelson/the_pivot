class Venue < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false },
                     length: { in: 2..60 }
  validates :location, presence: true

  has_many :events
end
