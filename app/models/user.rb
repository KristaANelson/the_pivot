class User < ActiveRecord::Base
  has_secure_password
  validates :full_name, presence: true
  validates :email, uniqueness: true
  validates :display_name, length: { in: 2..32 }, allow_nil: true
  enum role: %w(default admin)
end
