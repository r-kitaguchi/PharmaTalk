require 'rails_helper'

RSpec.describe "学生プロフィールページ", type: :system do
  let(:student_profile) { build(:student_profile) }
  let(:student) { create(:student) }

  before do
    sign_in student
    visit new_student_profile_path(student)
  end

  context "正しい値を入力した時" do
    before do
      fill_in "student_profile_name", with: student_profile.name
      image_path = Rails.root.join('spec/fixtures/test.jpg')
      attach_file("student_profile_image", image_path)
      fill_in "student_profile_university", with: student_profile.university
      choose "student_profile_year_５年"
      fill_in "student_profile_introduction", with: student_profile.introduction
      click_on "登録"
    end

    it "マイページに移動すること" do
      expect(current_path).to eq student_path(student)
    end

    it "フラッシュが表示されること" do
      expect(page).to have_content "プロフィールを登録しました。"
    end

    it "プロフィール写真がヘッダーに表示されること" do
      within '.header_content' do
        expect(page).to have_selector("img[src$='test.jpg']")
      end
    end
  end

  context "バリデーションに引っかかった時" do
    before do
      fill_in "student_profile_name", with: " "
      fill_in "student_profile_university", with: student_profile.university
      choose "student_profile_year_５年"
      fill_in "student_profile_introduction", with: student_profile.introduction
      click_on "登録"
    end

    it "プロフィール登録ページに留まること" do
      within '.form_profile' do
        expect(page).to have_content "プロフィール登録"
      end
    end

    it "エラーメッセージが表示されること" do
      expect(page).to have_content "入力してください"
    end
  end
end
