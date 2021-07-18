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

      it "メールアドレスを変更できないこと" do
        @pharmacist = Pharmacist.find(pharmacist.id)
        expect(@pharmacist.email).not_to eq "pharmacist_mail@sample.com"
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

      it "メールアドレスが更新されること" do
        @pharmacist = Pharmacist.find(pharmacist.id)
        expect(@pharmacist.email).to eq "pharmacist_mail@sample.com"
      end

      it "ホームに移動すること" do
        expect(current_path).to eq root_path
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

      it "新しく入力したパスワードが有効でないこと" do
        fill_in "pharmacist_current_password", with: "pharmacistpas"
        click_on "更新"
        expect(page).to have_content("現在のパスワードは不正な値です")
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

      # メールアドレスのテストと同じように書くと、@pharmacist.password は nil　になるので、
      # 回りくどいが、以下の方法でテストする。
      it "新しいパスワードを使ってメールアドレスを変更できること" do
        visit edit_pharmacist_registration_path
        fill_in "pharmacist_email", with: "pharmacist_mail@sample.com"
        fill_in "pharmacist_current_password", with: "pharmacistpas"
        click_on "更新"
        @pharmacist = Pharmacist.find(pharmacist.id)
        expect(@pharmacist.email).to eq "pharmacist_mail@sample.com"
      end

      it "ホームに移動すること" do
        expect(current_path).to eq root_path
      end
    end
  end
end
