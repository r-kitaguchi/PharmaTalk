require 'rails_helper'

RSpec.describe "薬剤師プロフィールページ", type: :system do
  let(:pharmacist_profile) { build(:pharmacist_profile) }
  let(:pharmacist) { create(:pharmacist) }

  before do
    sign_in pharmacist
    visit new_pharmacist_profile_path(pharmacist)
  end

  context "正しい値を入力した時" do
    before do
      fill_in "pharmacist_profile_name", with: pharmacist_profile.name
      fill_in "pharmacist_profile_work_place", with: pharmacist_profile.work_place
      choose "pharmacist_profile_work_place_type_調剤薬局"
      fill_in "pharmacist_profile_university", with: pharmacist_profile.university
      fill_in "pharmacist_profile_introduction", with: pharmacist_profile.introduction
      click_on "登録"
    end

    it "マイページに移動すること" do
      expect(current_path).to eq pharmacist_path(pharmacist)
    end

    it "フラッシュが表示されること" do
      expect(page).to have_content "プロフィールを登録しました。"
    end
  end

  context "バリデーションに引っかかった時" do
    before do
      fill_in "pharmacist_profile_name", with: " "
      fill_in "pharmacist_profile_work_place", with: pharmacist_profile.work_place
      choose "pharmacist_profile_work_place_type_調剤薬局"
      fill_in "pharmacist_profile_university", with: pharmacist_profile.university
      fill_in "pharmacist_profile_introduction", with: pharmacist_profile.introduction
      click_on "登録"
    end

    it "プロフィール登録ページに留まること" do
      expect(page).to have_content "プロフィール登録"
    end

    it "エラーメッセージが表示されること" do
      expect(page).to have_content "入力してください"
    end
  end
end
