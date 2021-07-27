FactoryBot.define do
  factory :pharmacist_profile do
    name { "田中太郎" }
    image { nil }
    work_place { "田中薬局" }
    work_place_type { 0 }
    work_location { 0 }
    university { "東京大学" }
    introduction { "MyText" }
    association :pharmacist

    trait :image do
      image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    end
  end

end
