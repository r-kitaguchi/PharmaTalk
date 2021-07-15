class StudentProfile < ApplicationRecord
  belongs_to :student

  mount_uploader :image, StudentImageUploader

  validates :name, presence: true, length: { maximum: 255 }
  validates :university, presence: true, length: { maximum: 255 }
  validates :year, presence: true
  validates :introduction, presence: true, length: { maximum: 1000 }
end
