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

  it "パスワードが６文字以上でなければ無効な状態であること" do
    student = build(:student, password: "paspa")
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
