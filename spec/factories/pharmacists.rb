FactoryBot.define do
  factory :pharmacist do
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
  end
end
