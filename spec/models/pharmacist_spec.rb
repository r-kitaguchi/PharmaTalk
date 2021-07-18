require 'rails_helper'

RSpec.describe Pharmacist, type: :model do
  it "メールアドレスとパスワードがあれば有効な状態であること" do
    pharmacist = build(:pharmacist)
    expect(pharmacist).to be_valid
  end

  it "メールアドレスがなければ無効な状態であること" do
    pharmacist = build(:pharmacist, email: nil)
    pharmacist.valid?
    expect(pharmacist.errors[:email]).to include("を入力してください")
  end

  it "パスワードがなければ無効な状態であること" do
    pharmacist = build(:pharmacist, password: nil)
    pharmacist.valid?
    expect(pharmacist.errors[:password]).to include("を入力してください")
  end

  it "パスワードが6文字であれば有効な状態であること" do
    pharmacist = build(:pharmacist, password: "#{'a'*6}", password_confirmation: "#{'a'*6}")
    expect(pharmacist).to be_valid
  end

  it "パスワードが5文字であれば無効な状態であること" do
    pharmacist = build(:pharmacist, password: "#{'a'*5}", password_confirmation: "#{'a'*5}")
    pharmacist.valid?
    expect(pharmacist.errors[:password]).to include("は6文字以上で入力してください")
  end

  it "重複したメールアドレスなら無効な状態であること" do
    create(:pharmacist, email: "pharmacy@example.com")
    pharmacist = build(:pharmacist, email: "pharmacy@example.com")
    pharmacist.valid?
    expect(pharmacist.errors[:email]).to include("はすでに存在します")
  end
end
