require 'rails_helper'

RSpec.describe "ヘッダーのドロップダウンメニュー", type: :system do
  let(:pharmacist) { create(:pharmacist) }
  let(:pharmacist_profile) { build(:pharmacist_profile) }
  let(:student){ create(:student) }
  let(:student_profile) { build(:student_profile) }

  describe "薬剤師ログイン中" do
    before do
      sign_in pharmacist
      pharmacist_profile_registration
    end

    context "ヘッダーのプロフィール画像をマウスオーバーしている時" do
      before do
        @pharmacist_profile = PharmacistProfile.find_by(pharmacist_id: pharmacist.id)
        find(".drop_down").hover
      end

      it "マイページのリンクをクリックすると、正しいページに移動できること", js: true do
        click_on "マイページ"
        expect(current_path).to eq pharmacist_path(pharmacist)
      end

      it "プロフィールのリンクをクリックすると、正しいページに移動できること", js: true do
        click_on "プロフィール"
        expect(current_path).to eq pharmacist_profile_path(@pharmacist_profile)
      end

      it "アカウント編集のリンクをクリックすると、正しいページに移動できること", js: true do
        click_on "アカウント編集"
        expect(current_path).to eq edit_pharmacist_registration_path
      end

      it "ログアウトをクリックすると、ユーザーアイコンが表示されなくなること", js: true do
        click_on "ログアウト"
        expect(page).not_to have_selector(".drop_down")
      end
    end
  end

  describe "学生ログイン中" do
    before do
      sign_in student
      student_profile_registration
    end

    context "ヘッダーのプロフィール画像をマウスオーバーしている時" do
      before do
        @student_profile = StudentProfile.find_by(student_id: student.id)
        find(".drop_down").hover
      end

      it "マイページのリンクをクリックすると、正しいページに移動できること", js: true do
        click_on "マイページ"
        expect(current_path).to eq student_path(student)
      end

      it "プロフィールのリンクをクリックすると、正しいページに移動できること", js: true do
        click_on "プロフィール"
        expect(current_path).to eq student_profile_path(@student_profile)
      end

      it "アカウント編集のリンクをクリックすると、正しいページに移動できること", js: true do
        click_on "アカウント編集"
        expect(current_path).to eq edit_student_registration_path
      end

      it "ログアウトをクリックすると、ユーザーアイコンが表示されなくなること", js: true do
        click_on "ログアウト"
        expect(page).not_to have_selector(".drop_down")
      end
    end
  end
end
