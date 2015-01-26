class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates :user_id, presence: true

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
end
