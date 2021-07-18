require 'rails_helper'

RSpec.describe "学生プロフィールページ", type: :system do
  let(:student) { create(:student) }
  let(:student_profile) { create(:student_profile) }

  context "プロフィール画像を登録している時" do
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

    it "プロフィール画像が表示されていること" do
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

  context "プロフィール画像を登録していない時" do
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
