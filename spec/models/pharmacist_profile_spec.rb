require 'rails_helper'

RSpec.describe PharmacistProfile, type: :model do
  it "名前、勤務先、勤務先タイプ、勤務地、大学名、自己紹介があれば有効であること" do
    pharmacist_profile = build(:pharmacist_profile)
    expect(pharmacist_profile).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    is_expected.to validate_presence_of :name
  end

  it "名前の文字数は255文字以内であること" do
    is_expected.to validate_length_of(:name).is_at_most(255)
  end

  it "勤務先がなければ無効な状態であること" do
    is_expected.to validate_presence_of :work_place
  end

  it "勤務先の文字数は255文字以内であること" do
    is_expected.to validate_length_of(:work_place).is_at_most(255)
  end

  it "勤務先タイプがなければ無効な状態であること" do
    is_expected.to validate_presence_of :work_place_type
  end

  it "大学名がなければ無効な状態であること" do
    is_expected.to validate_presence_of :university
  end

  it "大学名の文字数は255文字以内であること" do
    is_expected.to validate_length_of(:university).is_at_most(255)
  end

  it "自己紹介がなければ無効な状態であること" do
    is_expected.to validate_presence_of :introduction
  end

  it "自己紹介の文字数は1000文字以内であること" do
    is_expected.to validate_length_of(:introduction).is_at_most(1000)
  end
end
