class Server < ApplicationRecord
  belongs_to :user
  has_many :server_users
  has_many :users, through: :server_users
end
