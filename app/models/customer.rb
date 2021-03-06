class Customer < ApplicationRecord
  VALID_PHONE = /\A[0]{1}[19]{1}[0-9]{8,9}\z/
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/is
  enum role: {customer: 0, admin: 1}
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :booking_tickets, dependent: :delete_all
  has_many :invoices, dependent: :delete_all
  validates :email, format: {with: VALID_EMAIL}
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.max_lenght_email}
  validates :name, presence: true, length: {maximum: Settings.max_lenght_name}
  validates :password, presence: true, length: {minimum: Settings.min_lenght_pass}, allow_nil: true
  has_secure_password
  before_save :downcase_email
  before_create :create_activation_digest
  scope :newest, ->{order created_at: :desc}
  scope :atoz, ->{order name: :asc}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = Customer.new_token
    update_columns remember_digest: Customer.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_columns remember_digest: nil
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = Customer.new_token
    update_columns reset_digest: Customer.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.time_mail_expire.hours.ago
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = Customer.new_token
    self.activation_digest = Customer.digest(activation_token)
  end
end
