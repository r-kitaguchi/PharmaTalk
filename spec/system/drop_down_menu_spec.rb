require 'rails_helper'

RSpec.describe "ヘッダーのドロップダウンメニュー", type: :system do
  let(:pharmacist) { create(:pharmacist, pharmacist_profile: pharmacist_profile) }
  let(:pharmacist_profile) { build(:pharmacist_profile) }
  let(:student){ create(:student, student_profile: student_profile) }
  let(:student_profile) { build(:student_profile) }

  describe "薬剤師ログイン中" do
    before do
      sign_in pharmacist
      visit root_path
    end

    context "ヘッダーのプロフィール画像をマウスオーバーしている時" do
      before do
        find(".drop_down").hover
      end

      it "マイページへのリンクがあること", js: true do
        expect(page).to have_link "マイページ", href: pharmacist_path(pharmacist)
      end

      it "プロフィールへのリンクがあること", js: true do
        expect(page).to have_link "プロフィール", href: pharmacist_profile_path(pharmacist_profile)
      end

      it "アカウント編集へのリンクがあること", js: true do
        expect(page).to have_link "アカウント編集", href: edit_pharmacist_registration_path
      end

      it "ログアウトリンクがあること", js: true do
        expect(page).to have_link "ログアウト", href: destroy_pharmacist_session_path
      end
    end

    context "ヘッダーのプロフィール画像をマウスオーバーしていない時" do
      it "マイページへのリンクがないこと", js: true do
        expect(page).not_to have_link "マイページ", href: pharmacist_path(pharmacist)
      end

      it "プロフィールへのリンクがないこと", js: true do
        expect(page).not_to have_link "プロフィール", href: pharmacist_profile_path(pharmacist_profile)
      end

      it "アカウント編集へのリンクがないこと", js: true do
        expect(page).not_to have_link "アカウント編集", href: edit_pharmacist_registration_path
      end

      it "ログアウトリンクがないこと", js: true do
        expect(page).not_to have_link "ログアウト", href: destroy_pharmacist_session_path
      end
    end
  end

  describe "学生ログイン中" do
    before do
      sign_in student
      visit root_path
    end

    context "ヘッダーのプロフィール画像をマウスオーバーしている時" do
      before do
        find(".drop_down").hover
      end

      it "マイページへのリンクがあること", js: true do
        expect(page).to have_link "マイページ", href: student_path(student)
      end

      it "プロフィールへのリンクがあること", js: true do
        expect(page).to have_link "プロフィール", href: student_profile_path(student_profile)
      end

      it "アカウント編集へのリンクがあること", js: true do
        expect(page).to have_link "アカウント編集", href: edit_student_registration_path
      end

      it "ログアウトリンクがあること", js: true do
        expect(page).to have_link "ログアウト", href: destroy_student_session_path
      end
    end

    context "ヘッダーのプロフィール画像をマウスオーバーしていない時" do
      it "マイページへのリンクがないこと", js: true do
        expect(page).not_to have_link "マイページ", href: student_path(student)
      end

      it "プロフィールへのリンクがないこと", js: true do
        expect(page).not_to have_link "プロフィール", href: student_profile_path(student_profile)
      end

      it "アカウント編集へのリンクがないこと", js: true do
        expect(page).not_to have_link "アカウント編集", href: edit_student_registration_path
      end

      it "ログアウトリンクがないこと", js: true do
        expect(page).not_to have_link "ログアウト", href: destroy_student_session_path
      end
    end
  end
end
