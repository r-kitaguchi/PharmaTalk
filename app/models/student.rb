class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :student_profile, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :pharmacists, through: :relationships
  has_many :rooms, dependent: :destroy
end
