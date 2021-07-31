class Notification < ApplicationRecord
  belongs_to :message
  belongs_to :pharmacist
  belongs_to :student
end
