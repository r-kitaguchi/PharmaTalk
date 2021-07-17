require 'rails_helper'

RSpec.describe "ログイン", type: :system do
  describe "薬剤師" do
    let(:pharmacist) { create(:pharmacist) }

    before do
      visit new_pharmacist_session_path
    end

    context "正しい値を入力した時" do
      before do
        fill_in "pharmacist_email", with: pharmacist.email
        fill_in "pharmacist_password", with: pharmacist.password
        click_on "ログイン"
      end

      it "マイページに移動すること" do
        expect(current_path).to eq pharmacist_path(pharmacist)
      end
    end

    context "間違った値を入力した時" do
      before do
        fill_in "pharmacist_email", with: "sample@sample.com"
        fill_in "pharmacist_password", with: pharmacist.password
        click_on "ログイン"
      end

      it "ログインページに留まること" do
        expect(page).to have_content("ログイン(薬剤師)")
      end

      it "エラーメッセージが表示されること" do
        expect(page).to have_content("違います")
      end
    end
  end

  describe "学生" do
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

      it "マイページに移動すること" do
        expect(current_path).to eq student_path(student)
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
end
