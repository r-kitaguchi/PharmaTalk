require 'rails_helper'

RSpec.describe PharmacistProfile, type: :model do
  it "名前、勤務先、勤務先タイプ、勤務地、大学名、自己紹介があれば有効であること" do
    pharmacist_profile = build(:pharmacist_profile)
    expect(pharmacist_profile).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    pharmacist_profile = build(:pharmacist_profile, name: nil)
    pharmacist_profile.valid?
    expect(pharmacist_profile.errors[:name]).to include("を入力してください")
  end

  it "勤務先がなければ無効な状態であること" do
    pharmacist_profile = build(:pharmacist_profile, work_place: nil)
    pharmacist_profile.valid?
    expect(pharmacist_profile.errors[:work_place]).to include("を入力してください")
  end

  it "勤務先タイプがなければ無効な状態であること" do
    pharmacist_profile = build(:pharmacist_profile, work_place_type: nil)
    pharmacist_profile.valid?
    expect(pharmacist_profile.errors[:work_place_type]).to include("を入力してください")
  end

  it "大学名がなければ無効な状態であること" do
    pharmacist_profile = build(:pharmacist_profile, university: nil)
    pharmacist_profile.valid?
    expect(pharmacist_profile.errors[:university]).to include("を入力してください")
  end

  it "自己紹介がなければ無効な状態であること" do
    pharmacist_profile = build(:pharmacist_profile, introduction: nil)
    pharmacist_profile.valid?
    expect(pharmacist_profile.errors[:introduction]).to include("を入力してください")
  end
end
