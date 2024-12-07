class Message < ApplicationRecord
  belongs_to :channel
  belongs_to :author, class_name: "User", foreign_key: "user_id" # Just to make easier to read later, I'm naming this "author" instead of "user"

  validates :content, presence: true, length: { maximum: 1000 }, allow_blank: false
end
