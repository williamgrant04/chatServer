class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :servers

  # Allows referencing "user.servers" to pull all servers the user is a member of, not just servers the user owns
  has_many :server_users
  has_many :servers, through: :server_users
end
