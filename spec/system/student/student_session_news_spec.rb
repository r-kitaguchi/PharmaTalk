require 'rails_helper'

RSpec.describe "学生ログインページ", type: :system do
  let(:student) { create(:student) }

  before do
    visit new_student_session_path
  end

  context "正しい値を入力した時" do
    before do
      fill_in "student_email", with: student.email
      fill_in "student_password", with: student.password
      click_on "ログイン"
    end

    it "ホームに移動すること" do
      expect(current_path).to eq root_path
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
