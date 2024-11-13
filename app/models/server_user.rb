class ServerUser < ApplicationRecord
  belongs_to :servers
  belongs_to :users
end
