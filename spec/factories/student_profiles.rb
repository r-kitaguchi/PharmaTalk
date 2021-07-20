FactoryBot.define do
  factory :student_profile do
    name { "学生太郎" }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    university { "Pharma大学" }
    year { 0 }
    introduction { "MyText" }
    association :student

    trait :no_image do
      image { nil }
    end
  end
end
