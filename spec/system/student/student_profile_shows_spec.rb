require 'rails_helper'

RSpec.describe "学生プロフィールページ", type: :system do
  let(:student) { create(:student, student_profile: student_profile) }
  let(:student_profile) { create(:student_profile) }
  let(:no_image_student) { create(:student, student_profile: no_image_student_profile)}
  let(:no_image_student_profile) { create(:student_profile, :no_image)}

  describe "ログインの有無" do
    context "ログインしている時" do
      it "プロフィール画面に移動できること" do
        sign_in student
        visit student_profile_path(student_profile)
        expect(current_path).to eq student_profile_path(student_profile)
      end
    end

    context "ログインしていない時" do
      it "プロフィール画面に移動しようとするとログインページにリダイレクトされること" do
        visit student_profile_path(student_profile)
        expect(current_path).to eq new_student_session_path
      end
    end
  end

  describe "プロフィール画像の有無" do
    context "プロフィール画像を登録している時" do
      before do
        sign_in student
        visit student_profile_path(student_profile)
      end

      it "名前が表示されていること" do
        expect(page).to have_content(student_profile.name)
      end

      it "学年が表示されていること" do
        expect(page).to have_content(student_profile.year)
      end

      it "プロフィール画像が表示されていること" do
        within ".profile_show_content" do
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end

      it "大学名が表示されていること" do
        expect(page).to have_content(student_profile.university)
      end

      it "自己紹介文が表示されていること" do
        expect(page).to have_content(student_profile.introduction)
      end
    end

    context "プロフィール画像を登録していない時" do
      before do
        sign_in no_image_student
        visit student_profile_path(no_image_student_profile)
      end

      it "デフォルト画像が表示されていること" do
        within '.profile_show_content' do
          expect(page).to have_selector("img[src$='/assets/default.png']")
        end
      end
    end
  end
end
