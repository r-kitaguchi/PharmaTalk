FactoryBot.define do
  factory :notification do
    association :message
    association :pharmacist
    association :student
  end
end
