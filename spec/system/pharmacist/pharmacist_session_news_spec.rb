require 'rails_helper'

RSpec.describe "薬剤師ログインページ", type: :system do
  let(:no_profile_pharmacist) { create(:pharmacist) }
  let(:pharmacist_profile) { create(:pharmacist_profile) }
  let(:pharmacist) { create(:pharmacist, pharmacist_profile: pharmacist_profile) }

  before do
    visit new_pharmacist_session_path
  end

  context "正しい値を入力した時" do
    context "プロフィール登録がまだ終わっていない時" do
      before do
        fill_in "pharmacist_email", with: no_profile_pharmacist.email
        fill_in "pharmacist_password", with: no_profile_pharmacist.password
        click_on "ログイン"
      end

      it "プロフィール登録画面に移動すること" do
        expect(current_path).to eq new_pharmacist_profile_path
      end
    end

    context "プロフィール登録が済んでいる時" do
      before do
        fill_in "pharmacist_email", with: pharmacist.email
        fill_in "pharmacist_password", with: pharmacist.password
        click_on "ログイン"
      end

      it "マイページに移動すること" do
        expect(current_path).to eq pharmacist_path(pharmacist)
      end
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
