require 'rails_helper'

RSpec.describe Pharmacist, type: :model do
  it "メールアドレスとパスワードがあれば有効な状態であること" do
    pharmacist = build(:pharmacist)
    expect(pharmacist).to be_valid
  end

  it "メールアドレスがなければ無効な状態であること" do
    is_expected.to validate_presence_of :email
  end

  it "パスワードがなければ無効な状態であること" do
    is_expected.to validate_presence_of :password
  end

  it "パスワードが6文字以上必要であること" do
    is_expected.to validate_length_of(:password).is_at_least(6)
  end

  it "重複したメールアドレスなら無効な状態であること" do
    is_expected.to validate_uniqueness_of(:email).case_insensitive
  end
end
