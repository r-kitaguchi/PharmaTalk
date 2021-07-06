require 'rails_helper'

RSpec.describe 'ホーム画面', type: :system do
  describe 'クリック時の挙動' do
    before do
      visit root_path
    end

    context 'リンク' do
      it 'Pharma Talkについてをクリックすると、正しいページに移動できること' do
        click_on 'Pharma Talkについて'
        expect(current_path).to eq concepts_path
      end
    end

    context 'モーダルの表示' do
      it '新規登録をクリックすると、モーダルが表示されること', js: true do
        find('.sign_up').click
        expect(page).to have_selector('.popup', visible: true)
      end
    end
  end
end
