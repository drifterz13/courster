class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :courses, dependent: :nullify

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
end
