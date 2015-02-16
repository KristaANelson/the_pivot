class Event < ActiveRecord::Base
  validates :title, presence: true, allow_blank: false,
                    uniqueness: { case_sensitive: false }
  validates :approved, presence: true, allow_blank: false
  validates :date, presence: true, allow_blank: false
  validates :image_id, presence: true
  validates :venue_id, presence: true
  belongs_to :image
  belongs_to :venue
end
