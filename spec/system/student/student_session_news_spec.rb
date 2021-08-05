require 'rails_helper'

RSpec.describe "学生ログインページ", type: :system do
  let(:no_profile_student) { create(:student) }
  let(:student_profile) { create(:student_profile) }
  let(:student) { create(:student, student_profile: student_profile) }


  before do
    visit new_student_session_path
  end

  context "正しい値を入力した時" do
    context "プロフィール登録がまだ終わっていない時" do
      before do
        fill_in "student_email", with: no_profile_student.email
        fill_in "student_password", with: no_profile_student.password
        click_on "ログイン"
      end

      it "プロフィール登録画面に移動すること" do
        expect(current_path).to eq new_student_profile_path
      end
    end

    context "プロフィール登録が済んでいる時" do
      before do
        fill_in "student_email", with: student.email
        fill_in "student_password", with: student.password
        click_on "ログイン"
      end

      it "マイページに移動すること" do
        expect(current_path).to eq student_path(student)
      end
    end
  end

  context "間違った値を入力した時" do
    before do
      fill_in "student_email", with: "sample@sample.com"
      fill_in "student_password", with: student.password
      click_on "ログイン"
    end

    it "ログインページに留まること" do
      expect(page).to have_content("ログイン(学生)")
    end

    it "エラーメッセージが表示されること" do
      expect(page).to have_content("違います")
    end
  end
end
