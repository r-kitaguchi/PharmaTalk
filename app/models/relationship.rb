class Relationship < ApplicationRecord
  belongs_to :pharmacist
  belongs_to :student

  validates :pharmacist_id, uniqueness: { scope: :student_id }
  validate :check_number_of_pharmacist
  validate :check_number_of_student

  def check_number_of_pharmacist
    if pharmacist && pharmacist.relationships.where(allow: true).count >= MAX_FOLLOW_COUNT
      errors.add(:base, "トークできるのは３人までです。")
    end
  end

  def check_number_of_student
    if student && student.relationships.count >= MAX_FOLLOW_COUNT
      errors.add(:base, "申請できるのは３人までです。")
    end
  end
end
