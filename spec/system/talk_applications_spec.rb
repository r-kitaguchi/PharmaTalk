require 'rails_helper'

RSpec.describe "トーク申請", type: :system do
  let(:pharmacist) { create(:pharmacist, pharmacist_profile: pharmacist_profile) }
  let(:pharmacist_profile) { create(:pharmacist_profile) }
  let(:student) { create(:student, student_profile: student_profile) }
  let(:student_profile) { create(:student_profile) }
  let(:three_pharmacist_profiles) { create_list(:pharmacist_profile, 3) }
  let(:three_student_profiles) { create_list(:student_profile, 3)}

  describe "薬剤師プロフィール画面" do
    context "トーク申請の上限に達していない時" do
      before do
        sign_in student
        visit pharmacist_profile_path(pharmacist_profile)
      end

      it "トークを申請するボタンが表示され、トーク申請を解除するボタンは表示されていないこと" do
        aggregate_failures do
          expect(page).to have_button("トークを申請する")
          expect(page).not_to have_button("トーク申請を解除する")
        end
      end

      context "トークを申請するボタンを押した時" do
        it "Relationship.countが１変化すること" do
          expect do
            click_button "トークを申請する"
          end.to change(Relationship, :count).by(1)
        end

        it "マイページに移動すること" do
          click_button "トークを申請する"
          expect(current_path).to eq student_path(student)
        end
      end
    end

    context "トーク申請の上限に達している時" do
      before do
        three_pharmacist_profiles.each do |profile|
          create(:relationship, pharmacist: profile.pharmacist, student: student)
        end
        sign_in student
      end

      context "申請済みの薬剤師のプロフィールページに行った時" do
        before do
          visit pharmacist_profile_path(three_pharmacist_profiles.first)
        end

        it "トーク申請を解除するボタンが表示され、トークを申請するボタンは表示されていないこと" do
          aggregate_failures do
            expect(page).not_to have_button("トークを申請する")
            expect(page).to have_button("トーク申請を解除する")
          end
        end

        it "トーク申請を解除するボタンを押すと、Relationship.countが１減ること" do
          expect do
            click_button "トーク申請を解除する"
          end.to change(Relationship, :count).by(-1)
        end
      end

      context "申請していない薬剤師のプロフィールページに行った時" do
        before do
           visit pharmacist_profile_path(pharmacist_profile)
        end

        it "トークを申請するボタンを押すと、エラーメッセージが表示されること" do
          click_button "トークを申請する"
          expect(page).to have_content("申請できるのは３人までです。")
        end
      end
    end

    context "薬剤師のトーク認証上限に達している時" do
      before do
        three_student_profiles.each do |profile|
          create(:relationship, pharmacist: pharmacist, student: profile.student, allow: true)
        end
        sign_in student
      end

      context "トーク認証上限に達した薬剤師のページに行った時" do
        before do
          visit pharmacist_profile_path(pharmacist_profile)
        end

        it "トーク認証上限に達したことが記され、申請ボタンが表示されていないこと" do
          aggregate_failures do
            expect(page).not_to have_button("トークを申請する")
            expect(page).to have_content("トーク相手の数が上限に達しました")
          end
        end
      end
    end
  end
end
