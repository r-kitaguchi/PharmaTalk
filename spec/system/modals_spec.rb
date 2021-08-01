require 'rails_helper'

RSpec.describe "モーダル", type: :system do
  before do
    visit root_path
  end

  describe "閉じる" do
    context "新規登録モーダルを表示させた時" do
      before(js: true) do
        within '.header_content' do
          find('.js_sign_up').click
        end
      end

      it "xボタンを押すとモーダルが見えなくなること", js: true do
        find(".close_btn").click
        expect(page).to have_selector('#popup_sign_up', visible: false)
      end
    end

    context "ログインモーダルを表示させた時" do
      before do
        find('.js_log_in').click
      end

      it "xボタンを押すとモーダルが見えなくなること", js: true do
        find(".close_btn").click
        expect(page).to have_selector('#popup_log_in', visible: false)
      end
    end
  end

  describe "新規登録" do
    before(js: true) do
      within '.header_content' do
        find('.js_sign_up').click
      end
    end

    context "薬剤師をクリックした時" do
      it "薬剤師の新規登録画面に移動できること" do
        within '#popup_sign_up' do
          click_link "薬剤師"
        end
        expect(current_path).to eq new_pharmacist_registration_path
      end
    end

    context "学生をクリックした時" do
      it "学生の新規登録画面に移動できること" do
        within '#popup_sign_up' do
          click_link "学生"
        end
        expect(current_path).to eq new_student_registration_path
      end
    end
  end

  describe "ログイン" do
    before(js: true) do
      find('.js_log_in').click
    end

    context "薬剤師をクリックした時" do
      it "薬剤師のログイン画面に移動できること" do
        within '#popup_log_in' do
          click_link "薬剤師"
        end
        expect(current_path).to eq new_pharmacist_session_path
      end
    end

    context "学生をクリックした時" do
      it "学生のログイン画面に移動できること" do
        within '#popup_log_in' do
          click_link "学生"
        end
        expect(current_path).to eq new_student_session_path
      end
    end
  end
end
