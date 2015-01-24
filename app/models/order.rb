class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items

  validates :user_id, presence: true

  def formatted_created_at
    created_at.strftime("%I:%M%P on %A, %B %-d, %Y")
  end
end
