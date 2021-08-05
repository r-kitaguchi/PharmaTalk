require 'rails_helper'

RSpec.describe Message, type: :model do
  it "contentがあれば有効な状態であること" do
    message = build(:message)
    expect(message).to be_valid
  end
  it "Roomモデルと多対１の関係であること" do
    is_expected.to belong_to(:room)
  end

  it "Notificationモデルと１対１の関係であること" do
    is_expected.to have_one(:notification)
  end

  it "contentがなければ無効な状態であること" do
    is_expected.to validate_presence_of :content
  end
end
