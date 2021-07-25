require 'rails_helper'

RSpec.describe StudentProfile, type: :model do
  it "名前、大学名、学年、自己紹介があれば有効であること" do
    student_profile = build(:student_profile)
    expect(student_profile).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    is_expected.to validate_presence_of :name
  end

  it "名前の文字数は255文字以内であること" do
    is_expected.to validate_length_of(:name).is_at_most(255)
  end

  it "大学名がなければ無効な状態であること" do
    is_expected.to validate_presence_of :university
  end

  it "大学名の文字数は255文字以内であること" do
    is_expected.to validate_length_of(:university).is_at_most(255)
  end


  it "学年がなければ無効な状態であること" do
    is_expected.to validate_presence_of :year
  end


  it "自己紹介がなければ無効な状態であること" do
    is_expected.to validate_presence_of :introduction
  end

  it "自己紹介の文字数は1000文字以内であること" do
    is_expected.to validate_length_of(:introduction).is_at_most(1000)
  end
end
