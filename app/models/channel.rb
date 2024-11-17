class Channel < ApplicationRecord
  belongs_to :server

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 50 }
end
