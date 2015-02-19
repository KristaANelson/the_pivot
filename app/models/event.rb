class Event < ActiveRecord::Base
  validates :title, presence: true, allow_blank: false,
                    uniqueness: { case_sensitive: false }
  validates :approved, inclusion: [true, false]
  validates :date, presence: true, allow_blank: false
  validates :image_id, presence: true
  validates :venue_id, presence: true

  belongs_to :image
  belongs_to :venue

  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :items

  scope :active_events, -> { where("venue_id = ?", Venue.id).active}
  scope :active,      -> { joins(:items).merge(Item.available).open_events }
  scope :open_events, -> { where("date >= ?", Date.today).is_approved }
  scope :is_approved, -> { where approved: true }

  # def self.active(venue = nil)
  #   event = where("date >= ?", Date.today)
  #   .where("approved = ?", true)
  #   .joins(:items).uniq
  #   .where(items: { pending: false })
  #   .where(items: { sold: false })
  #   event = event.where("venue_id = ?", venue.id) if venue
  #   event
  # end
end
