require 'rails_helper'

RSpec.describe "学生プロフィール編集ページ", type: :system do
  let(:student) { create(:student) }
  let(:student_profile) { create(:student_profile) }

  describe "プロフィール画像の表示" do
    context "プロフィール画像を登録している時" do
      before do
        sign_in student
        student_profile_registration(Rails.root.join('spec/fixtures/test.jpg'))
        visit edit_student_profile_path(student_profile)
      end

      it "プロフィール画像が表示されていること" do
        within ".edit_image" do
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end

      it "画像を削除するためのチェックボックスが表示されていること" do
        expect(page).to have_content("画像を削除する")
      end
    end

    context "プロフィール画像を登録していない時" do
      before do
        sign_in student
        student_profile_registration(nil)
        visit edit_student_profile_path(student_profile)
      end

      it "プロフィール画像の表示、画像を削除する項目の表示がないこと" do
        expect(page).not_to have_selector(".edit_image")
      end
    end
  end

  describe "プロフィールの更新" do
    before do
      sign_in student
      student_profile_registration(Rails.root.join('spec/fixtures/test.jpg'))
      visit edit_student_profile_path(student_profile)
    end

    context "正しい値を入力した時" do
      before do
        fill_in "student_profile_name", with: "山田太郎"
        fill_in "student_profile_university", with: student_profile.university
        choose "student_profile_year_５年"
        fill_in "student_profile_introduction", with: student_profile.introduction
        click_on "更新"
      end

      it "マイページに移動すること" do
        expect(current_path).to eq student_path(student)
      end

      it "フラッシュが表示されること" do
        expect(page).to have_content("プロフィールを更新しました")
      end
    end

    context "誤った値を入力した時" do
      before do
        fill_in "student_profile_name", with: ""
        fill_in "student_profile_university", with: student_profile.university
        choose "student_profile_year_５年"
        fill_in "student_profile_introduction", with: student_profile.introduction
        click_on "更新"
      end

      it "プロフィール編集ページから移動しないこと" do
        expect(page).to have_selector("h2", text: "プロフィール編集")
      end

      it "エラーメッセージが表示されること" do
        expect(page).to have_content("入力してください")
      end
    end
  end
end
