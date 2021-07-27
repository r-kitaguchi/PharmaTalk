class Pharmacist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :pharmacist_profile, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :students, through: :relationships
  has_many :rooms, dependent: :destroy
end
