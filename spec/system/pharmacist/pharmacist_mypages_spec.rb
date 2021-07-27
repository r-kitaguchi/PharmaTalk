require 'rails_helper'

RSpec.describe "薬剤師マイページ", type: :system do
  let(:pharmacist) { create(:pharmacist, pharmacist_profile: pharmacist_profile) }
  let(:pharmacist_profile) { create(:pharmacist_profile) }
  let(:image_pharmacist) { create(:pharmacist, pharmacist_profile: image_pharmacist_profile)}
  let(:image_pharmacist_profile) { create(:pharmacist_profile, :image)}
  let(:student) { create(:student, student_profile: student_profile) }
  let(:student_profile) { create(:student_profile, :image) }
  let(:three_student_profiles) { create_list(:student_profile, 3)}

  describe "プロフィール情報の表示" do
    it "自身の名前、勤務先タイプ、勤務地、勤務先、出身大学が表示されていること" do
      sign_in pharmacist
      visit pharmacist_path(pharmacist_profile)
      aggregate_failures do
        expect(page).to have_content(pharmacist_profile.name)
        expect(page).to have_content(pharmacist_profile.work_place_type)
        expect(page).to have_content(pharmacist_profile.work_location)
        expect(page).to have_content(pharmacist_profile.work_place)
        expect(page).to have_content(pharmacist_profile.university)
      end
    end

    context "プロフィール画像を登録していない時" do
      before do
        sign_in pharmacist
        visit pharmacist_path(pharmacist_profile)
      end

      it "デフォルト画像が表示されていること" do
        within '.pharmacist_profile' do
          expect(page).to have_selector("img[src$='/assets/default.png']")
        end
      end
    end

    context "プロフィール画像を登録している時" do
      before do
        sign_in image_pharmacist
        visit pharmacist_path(image_pharmacist_profile)
      end

      it "プロフィール画像が表示されていること" do
        within ".pharmacist_profile" do
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end
    end
  end

  describe "通知の表示" do
    before do
      sign_in pharmacist
    end

    context "学生によるトーク申請が行われ、まだ承認されていないとき" do
      before do
        create(:relationship, pharmacist: pharmacist, student: student)
        visit pharmacist_path(pharmacist)
      end

      it "学生のプロフィール写真、名前が表示されていること" do
        aggregate_failures do
          within '.notification' do
            expect(page).to have_content(student_profile.name)
            expect(page).to have_selector("img[src$='test.jpg']")
          end
        end
      end

      it "承認するボタンが表示されていること" do
        expect(page).to have_button("承認する")
      end

      it "承認するボタンを押すと、Relationshipのallowがtrueになること" do
        expect do
          click_button "承認する"
        end.to change{ Relationship.find_by(allow: true) }.from(be_falsey).to(be_truthy)
      end

      it "承認するボタンを押すと、フラッシュが表示されること" do
        click_button "承認する"
        expect(page).to have_content("承認しました")
      end
    end

    context "学生によるトーク申請が行われ、承認されている時" do
      before do
        create(:relationship, pharmacist: pharmacist, student: student, allow: true)
        visit pharmacist_path(pharmacist)
      end

      it "承認するボタンが表示されていないこと" do
        expect(page).not_to have_button("承認する")
      end
    end

    context "トーク承認の上限に達している時" do
      before do
        create(:relationship, pharmacist: pharmacist, student: student)
        three_student_profiles.each do |profile|
          create(:relationship, pharmacist: pharmacist, student: profile.student, allow: true)
        end
        visit pharmacist_path(pharmacist)
      end

      it "承認するボタンを押すと、エラーメッセージが表示されること" do
        click_button "承認する"
        expect(page).to have_content("トークできるのは３人までです。")
      end
    end
  end

  describe "トーク中の表示" do
    before do
      sign_in pharmacist
    end

    context "トークが承認された学生がいる時" do
      before do
        create(:relationship, pharmacist: pharmacist, student: student, allow: true)
        visit pharmacist_path(pharmacist)
      end

      it "トーク中の欄に学生のプロフィール写真、名前が表示されていること" do
        aggregate_failures do
          within ".talking" do
            expect(page).to have_content(student_profile.name)
            expect(page).to have_selector("img[src$='test.jpg']")
          end
        end
      end
    end
  end
end
