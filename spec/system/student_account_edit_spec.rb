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

      it "メールアドレスを変更できないこと" do
        @student = Student.find(student.id)
        expect(@student.email).not_to eq "student_mail@sample.com"
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

      it "メールアドレスが更新されること" do
        @student = Student.find(student.id)
        expect(@student.email).to eq "student_mail@sample.com"
      end

      it "ホームに移動すること" do
        expect(current_path).to eq root_path
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

      it "新しく入力したパスワードが有効でないこと" do
        fill_in "student_current_password", with: "studentpas"
        click_on "更新"
        expect(page).to have_content("現在のパスワードは不正な値です")
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

      it "新しいパスワードを使ってメールアドレスを変更できること" do
        visit edit_student_registration_path
        fill_in "student_email", with: "student_mail@sample.com"
        fill_in "student_current_password", with: "studentpas"
        click_on "更新"
        @student = Student.find(student.id)
        expect(@student.email).to eq "student_mail@sample.com"
      end

      it "ホームに移動すること" do
        expect(current_path).to eq root_path
      end
    end
  end
end
