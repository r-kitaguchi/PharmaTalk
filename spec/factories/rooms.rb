FactoryBot.define do
  factory :room do
    association :pharmacist
    association :student
  end
end
