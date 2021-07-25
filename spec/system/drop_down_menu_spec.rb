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

      it "マイページ、プロフィール、アカウント編集、ログアウトのリンクがあること", js: true do
        aggregate_failures do
          expect(page).to have_link "マイページ", href: pharmacist_path(pharmacist)
          expect(page).to have_link "プロフィール", href: pharmacist_profile_path(pharmacist_profile)
          expect(page).to have_link "アカウント編集", href: edit_pharmacist_registration_path
          expect(page).to have_link "ログアウト", href: destroy_pharmacist_session_path
        end
      end
    end

    context "ヘッダーのプロフィール画像をマウスオーバーしていない時" do
      it "マイページ、プロフィール、アカウント編集、ログアウトのリンクがないこと", js: true do
        aggregate_failures do
          expect(page).not_to have_link "マイページ", href: pharmacist_path(pharmacist)
          expect(page).not_to have_link "プロフィール", href: pharmacist_profile_path(pharmacist_profile)
          expect(page).not_to have_link "アカウント編集", href: edit_pharmacist_registration_path
          expect(page).not_to have_link "ログアウト", href: destroy_pharmacist_session_path
        end
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

      it "マイページ、プロフィール、アカウント編集、ログアウトのリンクがあること", js: true do
        aggregate_failures do
          expect(page).to have_link "マイページ", href: student_path(student)
          expect(page).to have_link "プロフィール", href: student_profile_path(student_profile)
          expect(page).to have_link "アカウント編集", href: edit_student_registration_path
          expect(page).to have_link "ログアウト", href: destroy_student_session_path
        end
      end
    end

    context "ヘッダーのプロフィール画像をマウスオーバーしていない時" do
      it "マイページ、プロフィール、アカウント編集、ログアウトのリンクがないこと", js: true do
        aggregate_failures do
          expect(page).not_to have_link "マイページ", href: student_path(student)
          expect(page).not_to have_link "プロフィール", href: student_profile_path(student_profile)
          expect(page).not_to have_link "アカウント編集", href: edit_student_registration_path
          expect(page).not_to have_link "ログアウト", href: destroy_student_session_path
        end
      end
    end
  end
end
