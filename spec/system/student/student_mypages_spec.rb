require 'rails_helper'

RSpec.describe "学生マイページ", type: :system do
  let(:student) { create(:student, student_profile: student_profile) }
  let(:student_profile) { create(:student_profile) }
  let(:image_student) { create(:student, student_profile: image_student_profile) }
  let(:image_student_profile) { create(:student_profile, :image)}
  let(:pharmacist) { create(:pharmacist, pharmacist_profile: pharmacist_profile) }
  let(:pharmacist_profile) { create(:pharmacist_profile, :image) }

  describe "プロフィール情報の表示" do
    it "自身の名前、学年、大学が表示されていること" do
      sign_in student
      visit student_path(student_profile)
      aggregate_failures do
        expect(page).to have_content(student_profile.name)
        expect(page).to have_content(student_profile.year)
        expect(page).to have_content(student_profile.university)
      end
    end

    context "プロフィール画像を登録していない時" do
      before do
        sign_in student
        visit student_path(student_profile)
      end

      it "デフォルト画像が表示されていること" do
        within '.student_profile' do
          expect(page).to have_selector("img[src$='/assets/default.png']")
        end
      end
    end

    context "プロフィール画像を登録している時" do
      before do
        sign_in image_student
        visit student_path(image_student_profile)
      end

      it "プロフィール画像が表示されていること" do
        within ".student_profile" do
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end
    end
  end

  describe "承認待ちの表示" do
    before do
      sign_in student
    end

    context "トーク申請を行い、まだ承認されていないとき" do
      before do
        create(:relationship, pharmacist: pharmacist, student: student)
        visit student_path(student)
      end

      it "薬剤師のプロフィール写真、名前が表示されていること" do
        aggregate_failures do
          within '.waiting' do
            expect(page).to have_content(pharmacist_profile.name)
            expect(page).to have_selector("img[src$='test.jpg']")
          end
        end
      end
    end

    context "トーク申請を行い、承認されている時" do
      before do
        create(:relationship, pharmacist: pharmacist, student: student, allow: true)
        visit student_path(student)
      end

      it "薬剤師のプロフィール写真、名前が表示されていないこと" do
        aggregate_failures do
          within '.waiting_column' do
            expect(page).not_to have_content(pharmacist_profile.name)
            expect(page).not_to have_selector("img[src$='test.jpg']")
          end
        end
      end
    end
  end
end
