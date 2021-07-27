require 'rails_helper'

RSpec.describe "学生プロフィール編集ページ", type: :system do
  let(:student) { create(:student, student_profile: student_profile) }
  let(:student_profile) { create(:student_profile) }
  let(:image_student) { create(:student, student_profile: image_student_profile)}
  let(:image_student_profile) { create(:student_profile, :image)}
  let(:other_student) { create(:student, student_profile: other_student_profile)}
  let(:other_student_profile) { create(:student_profile) }

  describe "ログインユーザーの種類" do
    context "自身のプロフィール編集ページにアクセスする時" do
      it "プロフィール編集ページにアクセスできること" do
        sign_in student
        visit edit_student_profile_path(student_profile)
        expect(current_path).to eq edit_student_profile_path(student_profile)
      end
    end

    context "他人のプロフィール編集ページにアクセスする時" do
      it "ホームにリダイレクトされること" do
        sign_in student
        visit edit_student_profile_path(other_student_profile)
        expect(current_path).to eq root_path
      end
    end
  end

  describe "プロフィール画像の表示" do
    context "プロフィール画像を登録していない時" do
      before do
        sign_in student
        visit edit_student_profile_path(student_profile)
      end

      it "プロフィール画像の表示、画像を削除する項目の表示がないこと" do
        expect(page).not_to have_selector(".edit_image")
      end
    end

    context "プロフィール画像を登録している時" do
      before do
        sign_in image_student
        visit edit_student_profile_path(image_student_profile)
      end

      it "プロフィール画像が表示されていること" do
        within ".edit_image" do
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end

      it "画像を削除するためのチェックボックスが表示されていること" do
        expect(page).to have_content("画像を削除する")
      end

      it "画像削除のチェックボックスにチェックを入れると、ヘッダーのアイコンがデフォルト画像になること" do
        check "student_profile_remove_image"
        click_on "更新"
        within '.header_content' do
          expect(page).to have_selector("img[src$='/assets/default.png']")
        end
      end
    end
  end

  describe "プロフィールの更新" do
    before do
      sign_in student
      visit edit_student_profile_path(student_profile)
    end

    context "正しい値を入力した時" do
      before do
        fill_in "student_profile_name", with: "山田太郎"
        fill_in "student_profile_university", with: "大学名"
        click_on "更新"
      end

      it "データが更新されること" do
        expect(student_profile.reload.name).to eq "山田太郎"
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
        fill_in "student_profile_name", with: "山田太郎"
        fill_in "student_profile_university", with: ""
        click_on "更新"
      end

      it "データが更新されないこと" do
        expect(student_profile.reload.name).not_to eq "山田太郎"
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
