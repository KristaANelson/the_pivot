class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates :user_id, presence: true

  scope :ordered, -> { where("status = ?", "ordered") }
  scope :paid, -> { where("status = ?", "paid") }
  scope :completed, -> { where("status = ?", "completed") }

  def formatted_created_at
    formatted_time(created_at)
  end

  def formatted_updated_at
    formatted_time(updated_at)
  end

  def formatted_date
    created_at.localtime.strftime("%b %-d, %Y")
  end

  def formatted_hour
    created_at.localtime.strftime("%I:%M%P")
  end

  def total_dollar_amount
    number_to_currency(total_price / 100.00)
  end

  def formatted_time(time_type)
    time_type.localtime.strftime("%I:%M%P on %A, %B %-d, %Y")
  end

  def updated?
    status == "completed" || status == "cancelled"
  end

  def order_total
    order_items.each.inject(0) { |sum, item| sum + item.line_item_price }
  end

  def paid?
    status == "paid"
  end

  def cancelable?
    status == "ordered" || status == "paid"
  end

  def payable?
    status == "ordered"
  end
end

# link to transition to a different status:
# link to "cancel" individual orders which are currently "ordered" or "paid"
# link to "mark as paid" orders which are "ordered"
# link to "mark as completed" individual orders which are currently "paid"
