FactoryBot.define do
  factory :message do
    is_pharmacist { false }
    content { "MyText" }
    association :room
  end
end
