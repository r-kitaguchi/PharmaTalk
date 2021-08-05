class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :student_profile, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :pharmacists, through: :relationships
  has_many :rooms, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def self.guest
    find_or_create_by(email: "student@sample.com") do |user|
      user.password = "password"
    end
  end
end
