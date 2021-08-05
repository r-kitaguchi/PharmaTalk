require 'rails_helper'

RSpec.describe Notification, type: :model do
  it "Pharmacistモデルと多対１の関係であること" do
    is_expected.to belong_to(:pharmacist)
  end

  it "Studentモデルと多対１の関係であること" do
    is_expected.to belong_to(:student)
  end

  it "Messageモデルと１対１の関係であること" do
    is_expected.to belong_to(:message)
  end
end
