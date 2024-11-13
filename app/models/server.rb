class Server < ApplicationRecord
  belongs_to :user
  belongs_to :server_user # Basically the members list
end
