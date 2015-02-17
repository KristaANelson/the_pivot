class Item < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :user
  belongs_to :event
  validates :unit_price, presence: true, allow_blank: false,
    numericality: { only_integer: true, greater_than: 0 }
  validates :section, presence: true
  validates :row, presence: true
  validates :seat, presence: true

  def has_category_items
    errors.add(:base, "must add at least one category") if category_items.blank?
  end

  def dollar_amount
    number_to_currency(unit_price / 100.00)
  end

  def category_list
    categories.map { |cat| cat.name }.join(", ")
  end

  def status
    if pending == true
      "Pending"
    else
      "Confirmed"
    end
  end

  scope :pending, -> { where(pending: true) }
  scope :confirmed, -> { where(pending: false) }
end
