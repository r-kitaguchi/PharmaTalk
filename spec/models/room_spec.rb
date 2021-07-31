require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:student) { create(:student) }
  let(:pharmacist) { create(:pharmacist) }

  it "Studentモデルと多対１の関係であること" do
    is_expected.to belong_to(:student)
  end

  it "Pharmacistモデルと多対１の関係であること" do
    is_expected.to belong_to(:pharmacist)
  end

  it "Messageモデルと１対多の関係であること" do
    is_expected.to have_many(:messages).dependent(:destroy)
  end

  it "studentとpharmacistの組み合わせは一意であること" do
    create(:room, pharmacist: pharmacist, student: student)
    other_room = build(:room, pharmacist: pharmacist, student: student)
    expect(other_room).not_to be_valid
  end
end
