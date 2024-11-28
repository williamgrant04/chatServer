class Channel < ApplicationRecord
  belongs_to :server
  has_many :default_channels, dependent: :destroy

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 50 }
end
