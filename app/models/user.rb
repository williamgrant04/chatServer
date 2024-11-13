class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :servers

  # Allows referencing "user.servers" to pull all servers the user is a member of, not just servers the user owns
  has_many :server_users
  has_many :servers, through: :server_users
end
