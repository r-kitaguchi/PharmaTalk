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

  it "Relationshipモデルと1対多の関係であること" do
    is_expected.to have_many(:relationships).dependent(:destroy)
  end

  it "PharmacistProfileモデルと1対1の関係であること" do
    is_expected.to have_one(:pharmacist_profile).dependent(:destroy)
  end

  it "Roomモデルと１対多の関係であること" do
    is_expected.to have_many(:rooms).dependent(:destroy)
  end

  it "Notificationモデルと１対多の関係であること" do
    is_expected.to have_many(:notifications).dependent(:destroy)
  end
end
