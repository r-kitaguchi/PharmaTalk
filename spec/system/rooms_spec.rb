require 'rails_helper'

RSpec.describe "Rooms", type: :system do
  let(:pharmacist) { create(:pharmacist, pharmacist_profile: pharmacist_profile) }
  let(:student) { create(:student, student_profile: student_profile) }
  let(:pharmacist_profile) { create(:pharmacist_profile, :image) }
  let(:student_profile) { create(:student_profile, :image) }
  let(:room) { create(:room, pharmacist: pharmacist, student: student) }

  describe "薬剤師ログイン中" do
    before do
      sign_in pharmacist
      create(:message, content: "学生のメッセージ", room: room)
      visit room_path(room)
    end

    it "相手の名前が左上に表示されていること" do
      within ".back_link" do
        expect(page).to have_content(student_profile.name)
      end
    end

    it "左上の相手の名前をクリックすると、マイページに戻れること" do
      find('.back_link').click
      expect(current_path).to eq pharmacist_path(pharmacist)
    end

    it "メッセージを送信すると、画面右側に送ったメッセージが表示されること" do
      fill_in "message_content", with: "メッセージ"
      click_on "送信"
      within ".right_side" do
        expect(page).to have_content("メッセージ")
      end
    end

    it "相手のメッセージとプロフィール画像が左側に表示されていること" do
      aggregate_failures do
        within ".left_side" do
          expect(page).to have_content("学生のメッセージ")
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end
    end
  end

  describe "学生ログイン中" do
    before do
      sign_in student
      create(:message, content: "薬剤師のメッセージ", room: room, is_pharmacist: true)
      visit room_path(room)
    end

    it "相手の名前が左上に表示されていること" do
      within ".back_link" do
        expect(page).to have_content(pharmacist_profile.name)
      end
    end

    it "左上の相手の名前をクリックすると、マイページに戻れること" do
      find('.back_link').click
      expect(current_path).to eq student_path(student)
    end

    it "メッセージを送信すると、画面右側に送ったメッセージが表示されること" do
      fill_in "message_content", with: "メッセージ"
      click_on "送信"
      within ".right_side" do
        expect(page).to have_content("メッセージ")
      end
    end

    it "相手のメッセージとプロフィール画像が左側に表示されていること" do
      aggregate_failures do
        within ".left_side" do
          expect(page).to have_content("薬剤師のメッセージ")
          expect(page).to have_selector("img[src$='test.jpg']")
        end
      end
    end
  end
end
