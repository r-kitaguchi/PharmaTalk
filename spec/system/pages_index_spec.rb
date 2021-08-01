require 'rails_helper'

RSpec.describe "ホーム画面", type: :system do
  before do
    visit root_path
  end

  describe "リンク" do
    it "Pharma Talkについてをクリックすると、正しいページに移動できること" do
      click_on "Pharma Talkについて"
      expect(current_path).to eq concepts_path
    end
  end

  describe "モーダルの表示" do
    context "ヘッダーのログインをクリックした時" do
      it "ログインモーダルが表示されること", js: true do
        find('.js_log_in').click
        expect(page).to have_selector('#popup_log_in', visible: true)
      end
    end

    context "ヘッダーの新規登録をクリックした時" do
      it "新規登録モーダルが表示されること", js: true do
        within '.header_content' do
          find('.js_sign_up').click
        end
        expect(page).to have_selector('#popup_sign_up', visible: true)
      end
    end

    context "メインの新規登録をクリックした時" do
      it "新規登録モーダルが表示されること", js: true do
        within '.home_header_content' do
          find('.js_sign_up').click
        end
        expect(page).to have_selector('#popup_sign_up', visible: true)
      end
    end

    context "何もクリックしていない時" do
      it "モーダルが表示されていないこと" do
        aggregate_failures do
          expect(page).to have_selector('#popup_log_in', visible: false)
          expect(page).to have_selector('#popup_sign_up', visible: false)
        end
      end
    end
  end
end
