class User < ActiveRecord::Base
  has_secure_password
  has_many :items
  has_many :orders
  has_many :order_items, through: :orders

  before_save :generate_slug

  validates :full_name, presence: true, length: { in: 5..100 },
  format: { with: /\A[a-z ,.'-]+\z/i,  message: "Incorrect name format" }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Invalid" },
  uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :display_name, length: { in: 2..32 }, presence: true
  validates :slug, uniqueness: true

  def admin?
    false
  end

  private

  def generate_slug
    self.slug = display_name.parameterize
  end
end
