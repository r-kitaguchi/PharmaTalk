require 'rails_helper'

RSpec.describe "新規登録", type: :system do
  describe "薬剤師" do
    let(:pharmacist) { build(:pharmacist) }

    before do
      visit new_pharmacist_registration_path
    end

    context "正しい値を入力した時" do
      before do
        fill_in "pharmacist_email", with: pharmacist.email
        fill_in "pharmacist_password", with: pharmacist.password
        fill_in "pharmacist_password_confirmation", with: pharmacist.password_confirmation
        click_on "メールアドレスで登録"
      end

      it "プロフィールページに移動すること" do
        current_pharmacist = Pharmacist.find_by(email: pharmacist.email)
        expect(current_path).to eq new_pharmacist_profile_path(current_pharmacist)
      end

      it "ヘッダーにプロフィール登録ページへのリンクがあること" do
        within '.header_content' do
          current_pharmacist = Pharmacist.find_by(email: pharmacist.email)
          expect(page).to have_link "プロフィールを登録", href: new_pharmacist_profile_path(current_pharmacist)
        end
      end
    end

    context "間違った値を入力した時" do
      before do
        fill_in "pharmacist_email", with: " "
        fill_in "pharmacist_password", with: pharmacist.password
        fill_in "pharmacist_password_confirmation", with: pharmacist.password_confirmation
        click_on "メールアドレスで登録"
      end

      it "新規登録ページに留まること" do
        expect(page).to have_content("新規登録(薬剤師)")
      end
    end
  end

  describe "学生" do
    let(:student) { build(:student) }

    before do
      visit new_student_registration_path
    end

    context "正しい値を入力した時" do
      before do
        fill_in "student_email", with: student.email
        fill_in "student_password", with: student.password
        fill_in "student_password_confirmation", with: student.password_confirmation
        click_on "メールアドレスで登録"
      end

      # it "プロフィールページに移動すること" do
      #     current_student = Student.find_by(email: student.email)
      #   expect(current_path).to eq new_student_profile_path(student)
      # end

      # it "ヘッダーにプロフィール登録ページへのリンクがあること" do
      #   within '.header_content' do
      #     expect(page).to have_link "プロフィールを登録", new_student_profile_path(current_student)
      #   end
      # end
    end

    context "間違った値を入力した時" do
      before do
        fill_in "student_email", with: " "
        fill_in "student_password", with: student.password
        fill_in "student_password_confirmation", with: student.password_confirmation
        click_on "メールアドレスで登録"
      end

      it "新規登録ページに留まること" do
        expect(page).to have_content("新規登録(学生)")
      end
    end
  end
end
