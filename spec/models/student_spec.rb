require 'rails_helper'

RSpec.describe Student, type: :model do
  it "メールアドレスとパスワードがあれば有効な状態であること" do
    student = build(:student)
    expect(student).to be_valid
  end

  it "メールアドレスがなければ無効な状態であること" do
    student = build(:student, email: nil)
    student.valid?
    expect(student.errors[:email]).to include("を入力してください")
  end

  it "パスワードがなければ無効な状態であること" do
    student = build(:student, password: nil)
    student.valid?
    expect(student.errors[:password]).to include("を入力してください")
  end

  it "パスワードが6文字であれば有効な状態であること" do
    student = build(:student, password: "#{'a'*6}", password_confirmation: "#{'a'*6}")
    expect(student).to be_valid
  end

  it "パスワードが5文字であれば無効な状態であること" do
    student = build(:student, password: "#{'a'*5}")
    student.valid?
    expect(student.errors[:password]).to include("は6文字以上で入力してください")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    create(:student, email: "pharmacy@example.com")
    student = build(:student, email: "pharmacy@example.com")
    student.valid?
    expect(student.errors[:email]).to include("はすでに存在します")
  end
end
