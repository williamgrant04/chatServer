class Server < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :server_users, dependent: :destroy
  has_many :members, through: :server_users, source: :user
  has_many :channels, dependent: :destroy
  has_one :default_channel, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 50 }

  after_create :create_server_user # Adds the server creator to the server as a member
  after_create :create_default_channel

  protected

  def create_server_user
    ServerUser.create(server: self, user: self.owner)
  end

  def create_default_channel
    channel = Channel.create(server: self, name: "general") # I'll keep this as "general" for now, but I might rename it later
    DefaultChannel.create(server: self, channel: channel)
  end
end
