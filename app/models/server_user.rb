class ServerUser < ApplicationRecord
  belongs_to :server
  belongs_to :user
end
