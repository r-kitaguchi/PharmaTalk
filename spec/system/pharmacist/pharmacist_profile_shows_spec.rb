require 'rails_helper'

RSpec.describe "薬剤師プロフィールページ", type: :system do
  let(:pharmacist) { create(:pharmacist, pharmacist_profile: pharmacist_profile) }
  let(:pharmacist_profile) { create(:pharmacist_profile) }
  let(:no_image_pharmacist) { create(:pharmacist, pharmacist_profile: no_image_pharmacist_profile)}
  let(:no_image_pharmacist_profile) { create(:pharmacist_profile, :no_image)}
  let(:other_pharmacist) { create(:pharmacist, pharmacist_profile: other_pharmacist_profile)}
  let(:other_pharmacist_profile) { create(:pharmacist_profile) }
  let(:student) { create(:student) }

  describe "ログインの有無" do
    context "薬剤師がログインしている時" do
      before do
        sign_in pharmacist
      end

      it "プロフィール画面に移動できること" do
        visit pharmacist_profile_path(pharmacist_profile)
        expect(current_path).to eq pharmacist_profile_path(pharmacist_profile)
      end

      context "自身のプロフィールページを表示している時" do
        before do
          visit pharmacist_profile_path(pharmacist_profile)
        end

        it "プロフィール編集へのリンクが表示されていること" do
          expect(page).to have_link("編集する", href: edit_pharmacist_profile_path(pharmacist_profile))
        end
      end

      context "他人のプロフィールページを表示している時" do
        before do
          visit pharmacist_profile_path(other_pharmacist_profile)
        end

        it "プロフィール編集へのリンクが表示されていないこと" do
          expect(page).not_to have_link("編集する", href: edit_pharmacist_profile_path(other_pharmacist_profile))
        end
      end
    end

    context "学生がログインしている時" do
      before do
        sign_in student
        visit pharmacist_profile_path(pharmacist_profile)
      end

      it "プロフィール画面に移動できること" do
        expect(current_path).to eq pharmacist_profile_path(pharmacist_profile)
      end

      it "プロフィール編集へのリンクが表示されていないこと" do
        expect(page).not_to have_link("編集する", href: edit_pharmacist_profile_path(pharmacist_profile))
      end
    end

    context "誰もログインしていない時" do
      it "プロフィール画面に移動しようとするとホームにリダイレクトされること" do
        visit pharmacist_profile_path(pharmacist_profile)
        expect(current_path).to eq root_path
      end
    end
  end

  describe "プロフィール情報の表示" do
    it "名前、勤務先タイプ、勤務地、勤務先、出身大学、自己紹介文が表示されていること" do
      sign_in pharmacist
      visit pharmacist_profile_path(pharmacist_profile)
      aggregate_failures do
        expect(page).to have_content(pharmacist_profile.name)
        expect(page).to have_content(pharmacist_profile.work_place_type)
        expect(page).to have_content(pharmacist_profile.work_location)
        expect(page).to have_content(pharmacist_profile.work_place)
        expect(page).to have_content(pharmacist_profile.university)
        expect(page).to have_content(pharmacist_profile.introduction)
      end
    end

    context "プロフィール画像を登録している時" do
      before do
        sign_in pharmacist
        visit pharmacist_profile_path(pharmacist_profile)
      end

      it "プロフィール画像が表示されていること" do
        within ".profile_show_content" do
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end
    end

    context "プロフィール画像を登録していない時" do
      before do
        sign_in no_image_pharmacist
        visit pharmacist_profile_path(no_image_pharmacist_profile)
      end

      it "デフォルト画像が表示されていること" do
        within '.profile_show_content' do
          expect(page).to have_selector("img[src$='/assets/default.png']")
        end
      end
    end
  end
end
