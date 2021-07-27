require 'rails_helper'

RSpec.describe "学生プロフィールページ", type: :system do
  let(:student) { create(:student, student_profile: student_profile) }
  let(:student_profile) { create(:student_profile) }
  let(:image_student) { create(:student, student_profile: image_student_profile)}
  let(:image_student_profile) { create(:student_profile, :image)}

  describe "ログインの有無" do
    context "ログインしている時" do
      it "プロフィール画面に移動できること" do
        sign_in student
        visit student_profile_path(student_profile)
        expect(current_path).to eq student_profile_path(student_profile)
      end
    end

    context "ログインしていない時" do
      it "プロフィール画面に移動しようとするとホームにリダイレクトされること" do
        visit student_profile_path(student_profile)
        expect(current_path).to eq root_path
      end
    end
  end

  describe "プロフィール情報の表示" do
    it "名前、学年、大学名、自己紹介文が表示されていること" do
      sign_in student
      visit student_profile_path(student_profile)
      aggregate_failures do
        expect(page).to have_content(student_profile.name)
        expect(page).to have_content(student_profile.year)
        expect(page).to have_content(student_profile.university)
        expect(page).to have_content(student_profile.introduction)
      end
    end

    context "プロフィール画像を登録していない時" do
      before do
        sign_in student
        visit student_profile_path(student_profile)
      end

      it "デフォルト画像が表示されていること" do
        within '.profile_show_content' do
          expect(page).to have_selector("img[src$='/assets/default.png']")
        end
      end
    end

    context "プロフィール画像を登録していない時" do
      before do
        sign_in image_student
        visit student_profile_path(image_student_profile)
      end

      it "プロフィール画像が表示されていること" do
        within ".profile_show_content" do
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end
    end
  end
end
