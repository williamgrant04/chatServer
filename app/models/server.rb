class Server < ApplicationRecord
  belongs_to :user
  has_many :server_users
  has_many :members, through: :server_users, source: :user

  after_create :create_server_user # Adds the server creator to the server as a member

  protected

  def create_server_user
    ServerUser.create(server: self, user: self.user)
  end
end
