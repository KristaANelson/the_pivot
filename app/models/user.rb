class User < ActiveRecord::Base
  attr_accessor :activation_token

  has_secure_password

  has_many :items
  has_many :orders
  has_many :order_items, through: :orders

  before_validation :generate_slug
  before_save       :downcase_email
  before_create     :create_activation_digest

  validates :full_name, presence: true, length: { in: 5..100 },
                        format: { with: /\A[a-z ,.\'-]+\z/i, }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :display_name, length: { in: 2..32 }, presence: true,
                           uniqueness: true,
                           format: { with: /\A[a-zA-Z0-9]+\z/, }

  def admin?
    false
  end

  def generate_slug
    self.slug = display_name.parameterize unless display_name.nil?
  end

  def group_events
    self.items.active.group_by { |item| item.event }
  end

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  private

    def downcase_email
      self.email = self.email.downcase
    end

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
