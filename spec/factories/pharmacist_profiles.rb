FactoryBot.define do
  factory :pharmacist_profile do
    name { "田中太郎" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))}
    work_place { "Pharma薬局" }
    work_place_type { 0 }
    work_location { 0 }
    university { "ファーマ大学" }
    introduction { "MyText" }
    association :pharmacist

    trait :no_image do
      image { nil }
    end
  end

end
