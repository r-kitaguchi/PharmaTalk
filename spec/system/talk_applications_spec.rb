require 'rails_helper'

RSpec.describe "トーク申請", type: :system do
  let(:pharmacist) { create(:pharmacist, pharmacist_profile: pharmacist_profile) }
  let(:pharmacist_profile) { create(:pharmacist_profile) }
  let(:pharmacist_1) { create(:pharmacist, pharmacist_profile: pharmacist_profile_1) }
  let(:pharmacist_2) { create(:pharmacist, pharmacist_profile: pharmacist_profile_2) }
  let(:pharmacist_3) { create(:pharmacist, pharmacist_profile: pharmacist_profile_3) }
  let(:pharmacist_profile_1) { create(:pharmacist_profile) }
  let(:pharmacist_profile_2) { create(:pharmacist_profile) }
  let(:pharmacist_profile_3) { create(:pharmacist_profile) }
  let(:student) { create(:student) }

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
        create(:relationship, pharmacist: pharmacist_1, student: student)
        create(:relationship, pharmacist: pharmacist_2, student: student)
        create(:relationship, pharmacist: pharmacist_3, student: student)
        sign_in student
      end

      context "申請済みの薬剤師のプロフィールページに行った時" do
        before do
          visit pharmacist_profile_path(pharmacist_profile_1)
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
  end
end
