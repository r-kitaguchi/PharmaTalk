require 'rails_helper'

RSpec.describe "薬剤師プロフィールページ", type: :system do
  let(:pharmacist) { create(:pharmacist) }
  let(:pharmacist_profile) { build(:pharmacist_profile) }

  before do
    sign_in pharmacist
  end

  context "正しい値を入力した時" do
    before do
      pharmacist_profile_registration
    end

    it "マイページに移動すること" do
      expect(current_path).to eq pharmacist_path(pharmacist)
    end

    it "フラッシュが表示されること" do
      expect(page).to have_content "プロフィールを登録しました。"
    end

    it "プロフィール写真がヘッダーに表示されること" do
      within '.header_content' do
        expect(page).to have_selector("img[src$='test.jpg']")
      end
    end

    it "再度プロフィール登録ページに行こうとするとホームに移動すること" do
      visit new_pharmacist_profile_path
      expect(current_path).to eq root_path
    end
  end

  context "バリデーションに引っかかった時" do
    before do
      visit new_pharmacist_profile_path(pharmacist)
      fill_in "pharmacist_profile_name", with: " "
      fill_in "pharmacist_profile_work_place", with: pharmacist_profile.work_place
      choose "pharmacist_profile_work_place_type_調剤薬局"
      fill_in "pharmacist_profile_university", with: pharmacist_profile.university
      fill_in "pharmacist_profile_introduction", with: pharmacist_profile.introduction
      click_on "登録"
    end

    it "プロフィール登録ページに留まること" do
      within '.form_profile' do
        expect(page).to have_content "プロフィール登録"
      end
    end

    it "エラーメッセージが表示されること" do
      expect(page).to have_content "入力してください"
    end
  end
end
