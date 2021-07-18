require 'rails_helper'

RSpec.describe StudentProfile, type: :model do
  it "名前、大学名、学年、自己紹介があれば有効であること" do
    student_profile = build(:student_profile)
    expect(student_profile).to be_valid
  end

  it "名前がなければ無効な状態であること" do
    student_profile = build(:student_profile, name: nil)
    student_profile.valid?
    expect(student_profile.errors[:name]).to include("を入力してください")
  end

  it "名前が255文字であれば有効であること" do
    student_profile = build(:student_profile, name: "#{'a' * 255}")
    expect(student_profile).to be_valid
  end

  it "名前が256文字であれば無効な状態であること" do
    student_profile = build(:student_profile, name: "#{'a' * 256}")
    student_profile.valid?
    expect(student_profile.errors[:name]).to include("は255文字以内で入力してください")
  end

  it "大学名がなければ無効な状態であること" do
    student_profile = build(:student_profile, university: nil)
    student_profile.valid?
    expect(student_profile.errors[:university]).to include("を入力してください")
  end

  it "大学名が255文字であれば有効であること" do
    student_profile = build(:student_profile, university: "#{'a' * 255}")
    expect(student_profile).to be_valid
  end

  it "大学名が256文字であれば無効な状態であること" do
    student_profile = build(:student_profile, university: "#{'a' * 256}")
    student_profile.valid?
    expect(student_profile.errors[:university]).to include("は255文字以内で入力してください")
  end

  it "学年がなければ無効な状態であること" do
    student_profile = build(:student_profile, year: nil)
    student_profile.valid?
    expect(student_profile.errors[:year]).to include("を入力してください")
  end

  it "自己紹介がなければ無効な状態であること" do
    student_profile = build(:student_profile, introduction: nil)
    student_profile.valid?
    expect(student_profile.errors[:introduction]).to include("を入力してください")
  end

  it "自己紹介が1000文字であれば有効であること" do
    student_profile = build(:student_profile, introduction: "#{'a' * 1000}")
    expect(student_profile).to be_valid
  end

  it "自己紹介が1001文字であれば無効な状態であること" do
    student_profile = build(:student_profile, introduction: "#{'a' * 1001}")
    student_profile.valid?
    expect(student_profile.errors[:introduction]).to include("は1000文字以内で入力してください")
  end
end
