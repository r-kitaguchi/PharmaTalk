require 'rails_helper'

RSpec.describe "新規登録(学生)", type: :system do
  let(:student) { build(:student) }

  context "正しい値を入力した時" do
    before do
      student_registration(student.email, student.password, student.password_confirmation)
    end

    it "プロフィールページに移動すること" do
      current_student = Student.find_by(email: student.email)
      expect(current_path).to eq new_student_profile_path
    end

    it "ヘッダーにプロフィール登録ページへのリンクがあること" do
      within '.header_content' do
        current_student = Student.find_by(email: student.email)
        expect(page).to have_link "プロフィールを登録", href: new_student_profile_path
      end
    end

    it "フラッシュメッセージが表示されていること" do
      expect(page).to have_content("アカウント登録が完了しました。")
    end
  end

  context "メールアドレスを入力しなかった時" do
    before do
      student_registration(nil, student.password, student.password_confirmation)
    end

    it "新規登録ページに留まること" do
      expect(page).to have_content("新規登録(学生)")
    end

    it "エラーメッセージが表示されること" do
      expect(page).to have_content("メールアドレスを入力してください")
    end
  end

  context "パスワードを入力しなかった時" do
    before do
      student_registration(student.email, nil, student.password_confirmation)
    end

    it "新規登録ページに留まること" do
      expect(page).to have_content("新規登録(学生)")
    end

    it "エラーメッセージが表示されること" do
      expect(page).to have_content("パスワードを入力してください")
    end
  end

  context "パスワードと確認用パスワードが異なる値だった時" do
    before do
      student_registration(student.email, "aaaaaa", "bbbbbb")
    end

    it "新規登録ページに留まること" do
      expect(page).to have_content("新規登録(学生)")
    end

    it "エラーメッセージが表示されること" do
      expect(page).to have_content("確認用パスワードとパスワードの入力が一致しません")
    end
  end
end
