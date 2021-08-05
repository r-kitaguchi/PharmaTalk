class Room < ApplicationRecord
  belongs_to :pharmacist
  belongs_to :student
  has_many :messages, dependent: :destroy

  validates :pharmacist_id, uniqueness: { scope: :student_id }
end
