class Category < ActiveRecord::Base
  validates :name, presence: true

  has_many :categorizations
  has_many :events, through: :categorizations
  has_many :items, through: :events
end
