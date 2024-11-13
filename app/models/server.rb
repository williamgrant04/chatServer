class Server < ApplicationRecord
  belongs_to :user
  has_many :server_users, dependent: :destroy
  has_many :members, through: :server_users, source: :user
  has_many :channels, dependent: :destroy

  after_create :create_server_user # Adds the server creator to the server as a member
  after_create :create_default_channel

  protected

  def create_server_user
    ServerUser.create(server: self, user: self.user)
  end

  def create_default_channel
    Channel.create(server: self, name: "general") # I'll keep this as "general" for now, but I might rename it later
  end
end
