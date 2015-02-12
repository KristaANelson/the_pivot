class Item < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  has_many :categories
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :image
  validates :unit_price, presence: true, allow_blank: false,
    numericality: { only_integer: true, greater_than: 0 }

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
    if active == true
      "Active"
    else
      "Inactive"
    end
  end

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
