require 'rails_helper'

RSpec.describe "薬剤師ログインページ", type: :system do
  let(:pharmacist) { create(:pharmacist) }

  before do
    visit new_pharmacist_session_path
  end

  context "正しい値を入力した時" do
    before do
      fill_in "pharmacist_email", with: pharmacist.email
      fill_in "pharmacist_password", with: pharmacist.password
      click_on "ログイン"
    end

    it "ホームに移動すること" do
      expect(current_path).to eq root_path
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
