class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  normalizes :email, with: -> email { email.strip.downcase }

  validates :password, length: { minimum: 12 }, if: -> { new_record? || !password.nil? }
  validate :password_complexity

  generates_token_for :password_reset, expires_in: 15.minutes do
    password_salt&.last(10)
  end

  private
    def password_complexity
      return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/
      errors.add :password, 'Password must include at least: 1 uppercase, 1 lowercase, 1 digit, and 1 special character (#?!@$%^&*-)'
  end
end
