require 'rails_helper'

RSpec.describe "学生アカウント編集", type: :system do
  let(:student) { create(:student) }

  before do
    sign_in student
    visit edit_student_registration_path
  end

  describe "メールアドレスの変更" do
    context "現在のパスワードを入力していない時" do
      before do
        fill_in "student_email", with: "student_mail@sample.com"
        click_on "更新"
      end

      it "アカウント編集ページから移動しないこと" do
        expect(page).to have_selector("h2", text: "アカウント編集")
      end

      it "エラーメッセージが表示されること" do
        expect(page).to have_content("現在のパスワードを入力してください")
      end
    end

    context "現在のパスワードを入力している時" do
      before do
        fill_in "student_email", with: "student_mail@sample.com"
        fill_in "student_current_password", with: student.password
        click_on "更新"
      end

      it "ホームに移動すること" do
        expect(current_path).to eq root_path
      end

      it "フラッシュが表示されること" do
        expect(page).to have_content("アカウント情報を変更しました")
      end
    end
  end

  describe "パスワードの更新" do
    context "現在のパスワードを入力していない時" do
      before do
        fill_in "student_password", with: "studentpas"
        fill_in "student_password_confirmation", with: "studentpas"
        click_on "更新"
      end

      it "アカウント編集ページから移動しないこと" do
        expect(page).to have_selector("h2", text: "アカウント編集")
      end

      it "エラーメッセージが表示されること" do
        expect(page).to have_content("現在のパスワードを入力してください")
      end
    end

    context "現在のパスワードを入力している時" do
      before do
        fill_in "student_password", with: "studentpas"
        fill_in "student_password_confirmation", with: "studentpas"
        fill_in "student_current_password", with: student.password
        click_on "更新"
      end

      it "ホームに移動すること" do
        expect(current_path).to eq root_path
      end

      it "フラッシュが表示されること" do
        expect(page).to have_content("アカウント情報を変更しました")
      end
    end
  end
end
