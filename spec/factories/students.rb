FactoryBot.define do
  factory :student do
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
    password_confirmation { "password"}
  end
end
