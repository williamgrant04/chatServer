class ServerUser < ApplicationRecord
  has_many :servers
  has_many :users
end
