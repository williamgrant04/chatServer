class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, length: { maximum: 100 }

  has_many :servers

  # Allows referencing "user.servers" to pull all servers the user is a member of, not just servers the user owns
  has_many :server_users
  has_many :servers, through: :server_users
end
