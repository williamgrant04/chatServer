class Server < ApplicationRecord
  belongs_to :user
  has_many :server_users
end
