class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates :user_id, presence: true

  def formatted_created_at
    created_at.strftime("%I:%M%P on %A, %B %-d, %Y")
  end

  def total_dollar_amount
    number_to_currency(total_price / 100.00)
  end
end
