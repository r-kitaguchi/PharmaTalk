require 'rails_helper'

RSpec.describe "プロフィールページ", type: :system do
  describe "薬剤師" do
    let(:pharmacist) { create(:pharmacist) }
    let(:pharmacist_profile) { create(:pharmacist_profile) }

    context "プロフィール写真を登録している時" do
      before do
        sign_in pharmacist
        pharmacist_profile_registration(Rails.root.join('spec/fixtures/test.jpg'))
        visit pharmacist_profile_path(pharmacist_profile.id)
      end

      it "名前が表示されていること" do
        expect(page).to have_content(pharmacist_profile.name)
      end

      it "勤務先タイプが表示されていること" do
        expect(page).to have_content(pharmacist_profile.work_place_type)
      end

      it "勤務地が表示されていること" do
        expect(page).to have_content(pharmacist_profile.work_location)
      end

      it "勤務先が表示されていること" do
        expect(page).to have_content(pharmacist_profile.work_place)
      end

      it "出身大学が表示されていること" do
        expect(page).to have_content(pharmacist_profile.university)
      end

      it "自己紹介文が表示されていること" do
        expect(page).to have_content(pharmacist_profile.introduction)
      end

      it "プロフィール写真が表示されていること" do
        within ".profile_show_content" do
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end
    end

    context "プロフィール写真を登録していない時" do
      before do
        sign_in pharmacist
        pharmacist_profile_registration(nil)
        visit pharmacist_profile_path(pharmacist_profile.id)
      end

      it "デフォルト画像が表示されていること" do
        within '.profile_show_content' do
          expect(page).to have_selector("img[src$='/assets/default.png']")
        end
      end
    end
  end

  describe "学生" do
    let(:student) { create(:student) }
    let(:student_profile) { create(:student_profile) }

    context "プロフィール写真を登録している時" do
      before do
        sign_in student
        student_profile_registration(Rails.root.join('spec/fixtures/test.jpg'))
        visit student_profile_path(student_profile.id)
      end

      it "名前が表示されていること" do
        expect(page).to have_content(student_profile.name)
      end

      it "学年が表示されていること" do
        expect(page).to have_content(student_profile.year)
      end

      it "プロフィール写真が表示されていること" do
        within ".profile_show_content" do
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end

      it "大学名が表示されていること" do
        expect(page).to have_content(student_profile.university)
      end

      it "自己紹介文が表示されていること" do
        expect(page).to have_content(student_profile.introduction)
      end
    end

    context "プロフィール写真を登録していない時" do
      before do
        sign_in student
        student_profile_registration(nil)
        visit student_profile_path(student_profile.id)
      end

      it "デフォルト画像が表示されていること" do
        within '.profile_show_content' do
          expect(page).to have_selector("img[src$='/assets/default.png']")
        end
      end
    end
  end
end
