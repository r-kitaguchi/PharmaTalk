require 'rails_helper'

RSpec.describe "薬剤師アカウント編集", type: :system do
  let(:pharmacist) { create(:pharmacist) }

  before do
    sign_in pharmacist
    visit edit_pharmacist_registration_path
  end

  describe "メールアドレスの変更" do
    context "現在のパスワードを入力していない時" do
      before do
        fill_in "pharmacist_email", with: "pharmacist_mail@sample.com"
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
        fill_in "pharmacist_email", with: "pharmacist_mail@sample.com"
        fill_in "pharmacist_current_password", with: pharmacist.password
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
        fill_in "pharmacist_password", with: "pharmacistpas"
        fill_in "pharmacist_password_confirmation", with: "pharmacistpas"
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
        fill_in "pharmacist_password", with: "pharmacistpas"
        fill_in "pharmacist_password_confirmation", with: "pharmacistpas"
        fill_in "pharmacist_current_password", with: pharmacist.password
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
