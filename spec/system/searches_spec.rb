require 'rails_helper'

RSpec.describe "薬剤師検索ページ", type: :system do
  let!(:pharmacist_profile) { create(:pharmacist_profile,
            image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sample1.png'))) }

  before do
    create_list(:pharmacist_profile, 3, work_place_type: 1, work_location: 1, university: "東京大学")
    create_list(:pharmacist_profile, 3, work_place_type: 0, work_location: 47, university: "東京大学")
    create_list(:pharmacist_profile, 3, work_place_type: 0, work_location: 1, university: "大阪大学")
    visit root_path
  end

  describe "検索結果画面の表示" do
    before do
      click_on "検索"
    end

    it "検索結果の画面が表示されること" do
      expect(current_path).to eq search_pharmacist_profiles_path
    end

    it "名前が表示されていること" do
      expect(page).to have_content(pharmacist_profile.name)
    end

    it "プロフィール画像が表示されていること" do
      expect(page).to have_selector("img[src$='sample1.png']")
    end

    it "勤務先タイプが表示されていること" do
      expect(page).to have_content(pharmacist_profile.work_place_type)
    end

    it "勤務地が表示されていること" do
      expect(page).to have_content(pharmacist_profile.work_location)
    end

    it "勤務先が表示されていること" do
      expect(page).to have_content(pharmacist_profile.work_place)
    end

    it "出身大学が表示されていること" do
      expect(page).to have_content(pharmacist_profile.university)
    end

    it "自己紹介文が表示されていること" do
      expect(page).to have_content(pharmacist_profile.introduction)
    end

    it "プロフィールページへのリンクがあること" do
      expect(page).to have_link("詳細", href: pharmacist_profile_path(pharmacist_profile))
    end
  end

  describe "検索機能" do
    context "フリーワードで大阪大学を入力した時" do
      before do
        fill_in "q_name_or_work_place_or_university_cont", with: "大阪大学"
        click_on "検索"
      end

      it "大阪大学出身の薬剤師が表示されること" do
        expect(page).to have_content("大阪大学", count: 3)
      end

      it "東京大学出身の薬剤師は表示されないこと" do
        expect(page).not_to have_content("東京大学")
      end
    end

    context "勤務先タイプでドラッグストアを選択した時" do
      before do
        check "ドラッグストア"
        click_on "検索"
      end

      it "勤務先タイプがドラッグストアの薬剤師が表示されること" do
        expect(page).to have_content("ドラッグストア", count: 3)
      end

      it "勤務先タイプが調剤薬局の薬剤師は表示されないこと" do
        expect(page).not_to have_content("調剤薬局")
      end
    end

    context "エリアで沖縄を選択した時" do
      before do
        check "沖縄"
        click_on "検索"
      end

      it "エリアが東京の薬剤師が表示されること" do
        expect(page).to have_content("沖縄", count: 3)
      end

      it "エリアが北海道の薬剤師は表示されないこと" do
        expect(page).not_to have_content("北海道")
      end
    end
  end
end
