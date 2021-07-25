require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:pharmacist) { create(:pharmacist) }
  let(:student) { create(:student) }
  let(:pharmacist_1) { create(:pharmacist) }
  let(:pharmacist_2) { create(:pharmacist) }
  let(:pharmacist_3) { create(:pharmacist) }
  let(:student_1) { create(:student) }
  let(:student_2) { create(:student) }
  let(:student_3) { create(:student) }

  it "Studentモデルと多対１の関係であること" do
    is_expected.to belong_to(:student)
  end

  it "Pharmacistモデルと多対１の関係であること" do
    is_expected.to belong_to(:pharmacist)
  end

  it "studentとpharmacistの組み合わせは一意であること" do
    create(:relationship, pharmacist: pharmacist, student: student)
    other_relationship = build(:relationship, pharmacist: pharmacist, student: student)
    expect(other_relationship).not_to be_valid
  end

  it "1人のstudentに対してpharmacistは3人までしか登録できないこと" do
    create(:relationship, pharmacist: pharmacist_1, student: student)
    create(:relationship, pharmacist: pharmacist_2, student: student)
    create(:relationship, pharmacist: pharmacist_3, student: student)
    other_relationship = build(:relationship, pharmacist: pharmacist, student: student)

    other_relationship.valid?
    expect(other_relationship.errors[:base]).to include "申請できるのは３人までです。"
  end

  it "1人のpharmacistに対してallowカラムがtrueのstudentは3人までしか登録できないこと" do
    create(:relationship, pharmacist: pharmacist, student: student_1, allow: true)
    create(:relationship, pharmacist: pharmacist, student: student_2, allow: true)
    create(:relationship, pharmacist: pharmacist, student: student_3, allow: true)
    other_relationship = build(:relationship, pharmacist: pharmacist, student: student, allow: true)

    other_relationship.valid?
    expect(other_relationship.errors[:base]).to include "トークできるのは３人までです。"
  end
end
