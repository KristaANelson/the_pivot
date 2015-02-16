class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :events, through: :categorizations
  validates :name, presence: true
end
