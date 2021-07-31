class Message < ApplicationRecord
  belongs_to :room
  has_one :notification, dependent: :destroy

  validates :content, presence: true
end
