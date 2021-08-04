require 'rails_helper'

RSpec.describe "薬剤師マイページ(トーク中の表示)", type: :system do
  let(:pharmacist) { create(:pharmacist, pharmacist_profile: pharmacist_profile) }
  let(:student) { create(:student, student_profile: student_profile) }
  let(:pharmacist_profile) { create(:pharmacist_profile) }
  let(:student_profile) { create(:student_profile, :image) }
  let(:room) { create(:room, pharmacist: pharmacist, student: student) }
  let(:my_message) { create(:message, content: "自分のメッセージ", room: room, is_pharmacist: true) }
  let(:partner_message) { create(:message, content: "相手のメッセージ", room: room, is_pharmacist: false) }

  before do
    sign_in pharmacist
  end

  context "トークを承認された学生がいない時" do
    before do
      create(:relationship, pharmacist: pharmacist, student: student)
      visit pharmacist_path(pharmacist)
    end

    it "トーク中の欄に学生のプロフィール写真、名前が表示されていないこと" do
      aggregate_failures do
        within ".talking_column" do
          expect(page).not_to have_content(student_profile.name)
          expect(page).not_to have_selector("img[src$='test.jpg']")
        end
      end
    end
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

    context "誰もメッセージを送っていない時" do
      context "トークルームへボタンをクリックした時" do
        it "Room.countが１変化すること" do
          expect do
            click_button "トーク画面へ"
          end.to change(Room, :count).by(1)
        end

        it "トークルームに移動すること" do
          click_on "トーク画面へ"
          expect(page).to have_title("トークルーム")
        end
      end
    end

    context "自身がトークルームでメッセージを送った時" do
      before do
        create(:notification, pharmacist: pharmacist, student: student, message: my_message, is_pharmacist: true)
        visit pharmacist_path(pharmacist)
      end

      it "自身のメッセージが表示されていること" do
        within ".talking" do
          expect(page).to have_content("自分のメッセージ")
        end
      end

      it "通知マークが表示されていないこと" do
        expect(page).not_to have_selector(".notification")
      end

      it "トーク画面へリンクをクリックすると、トークルームに移動すること" do
        click_on "トーク画面へ"
        expect(current_path).to eq room_path(room)
      end

      it "トークを終了するボタンをクリックしないと、モーダルが表示されないこと" do
        expect(page).to have_selector('#popup_end_talk', visible: false)
      end

      it "トークを終了するボタンをクリックすると、モーダルが表示されること", js: true do
        find('.js_end_talk').click
        expect(page).to have_selector('#popup_end_talk', visible: true)
      end
    end

    context "相手がトークルームでメッセージを送った時" do
      before do
        create(:notification, pharmacist: pharmacist, student: student, message: partner_message)
        visit pharmacist_path(pharmacist)
      end

      it "相手のメッセージが表示されていること" do
        within ".talking" do
          expect(page).to have_content("相手のメッセージ")
        end
      end

      context "トークルームに行ってメッセージを確認していない時" do
        it "通知マークが表示されていること" do
          expect(page).to have_selector(".notification")
        end
      end

      context "トークルームに行き、メッセージを確認した時" do
        before do
          click_on "トーク画面へ"
          visit pharmacist_path(pharmacist)
        end

        it "通知マークが表示されていないこと" do
          expect(page).not_to have_selector(".notification")
        end
      end
    end
  end
end
