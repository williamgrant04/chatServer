class DefaultChannel < ApplicationRecord
  belongs_to :server
  belongs_to :channel
end
