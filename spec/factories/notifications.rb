FactoryBot.define do
  factory :notification do
    is_pharmacist { false }
    association :message
    association :pharmacist
    association :student
  end
end
