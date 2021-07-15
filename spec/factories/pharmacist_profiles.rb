FactoryBot.define do
  factory :pharmacist_profile do
    name { "田中太郎" }
    work_place { "Pharma薬局" }
    work_place_type { "調剤薬局" }
    work_location { 0 }
    university { "ファーマ大学" }
    introduction { "MyText" }
    association :pharmacist
  end
end
