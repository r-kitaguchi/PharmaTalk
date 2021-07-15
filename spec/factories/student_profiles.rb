FactoryBot.define do
  factory :student_profile do
    name { "学生太郎" }
    university { "Pharma大学" }
    year { "５年" }
    introduction { "MyText" }
    association :student
  end
end
