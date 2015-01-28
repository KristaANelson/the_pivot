class OrderItem < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :order
  belongs_to :item

  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :quantity, presence: true

  def total_dollar_amount
    number_to_currency(line_item_price / 100.00)
  end
end
