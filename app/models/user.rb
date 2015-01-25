class User < ActiveRecord::Base
  has_secure_password
  has_many :orders

  validates :full_name, presence: true, length: { in: 5..100 },
  format: { with: /\A[a-z ,.'-]+\z/i,  message: "Incorect name format" }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with:  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "Not a valid email format"},
  uniqueness: { case_sensitive: false }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :display_name, length: { in: 2..32 }, allow_nil: true

  def admin?
    false
  end

end
