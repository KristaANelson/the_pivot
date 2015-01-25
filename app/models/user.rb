class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :order_items, through: :orders
  validates :full_name, presence: true
  validates :email, uniqueness: true
  validates :display_name, length: { in: 2..32 }, allow_nil: true
  enum role: %w(default admin)

  def admin?
    false
  end

end
