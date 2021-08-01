require 'rails_helper'

RSpec.describe "マイページのトーク終了モーダル", type: :system do
  let(:pharmacist) { create(:pharmacist, pharmacist_profile: pharmacist_profile) }
  let(:student) { create(:student, student_profile: student_profile) }
  let(:pharmacist_profile) { create(:pharmacist_profile) }
  let(:student_profile) { create(:student_profile, :image) }
  let(:room) { create(:room, pharmacist: pharmacist, student: student) }
  let(:message) { create(:message, room: room, is_pharmacist: true) }

  before do
    sign_in pharmacist
    create(:relationship, pharmacist: pharmacist, student: student, allow: true)
    create(:notification, pharmacist: pharmacist, student: student, message: message, is_pharmacist: true)
    visit pharmacist_path(pharmacist)
  end

  context "マイページのトークを終了するボタンを押し、モーダルを表示させた時" do
    before(js: true) do
      find('.js_end_talk').click
    end

    context "トークを終了するリンクをクリックした時" do
      it "Room.countが１減ること" do
        expect do
          click_on "トークを終了する"
        end.to change(Room, :count).by(-1)
      end

      it "Relationship.countが１減ること" do
        expect do
          click_on "トークを終了する"
        end.to change(Relationship, :count).by(-1)
      end

      it "フラッシュが表示されること" do
        click_on "トークを終了する"
        expect(page).to have_content("トークルームを削除しました")
      end
    end

    it "戻るボタンを押すと、モーダルが閉じること", js: true do
      expect(page).to have_selector('#popup_end_talk', visible: true)
      find('.back_btn').click
      expect(page).to have_selector('#popup_end_talk', visible: false)
    end
  end
end
