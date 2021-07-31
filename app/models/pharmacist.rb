class Pharmacist < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :pharmacist_profile, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :students, through: :relationships
  has_many :rooms, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def pharmacist_relationship_limit
    relationships.where(allow: true).count >= MAX_FOLLOW_COUNT
  end
end
