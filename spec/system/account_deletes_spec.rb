require 'rails_helper'

RSpec.describe "アカウント編集ページ(アカウント削除)", type: :system do
  let(:pharmacist) { create(:pharmacist) }

  before do
    sign_in pharmacist
    visit edit_pharmacist_registration_path
  end

  context "アカウント削除ボタンを押していない時" do
    it "アカウント削除モーダルが表示されていないこと" do
      expect(page).to have_selector('#popup_account_delete', visible: false)
    end
  end

  context "アカウント削除ボタンを押した時" do
    before(js: true) do
      find('.js_account_delete').click
    end

    it "アカウント削除モーダルが表示されること" do
      expect(page).to have_selector('#popup_account_delete', visible: true)
    end

    it "戻るボタンを押すと、モーダルが閉じること", js: true do
      find('.back_btn').click
      expect(page).to have_selector('#popup_account_delete', visible: false)
    end

    context "モーダルで表示されたアカウントを削除するリンクをクリックした時" do
      it "Pharmacist.countが１減ること" do
        expect do
          click_on "アカウントを削除する"
        end.to change(Pharmacist, :count).by(-1)
      end

      it "ホームに移動すること" do
        click_on "アカウントを削除する"
        expect(current_path).to eq root_path
      end

      it "フラッシュが表示されること" do
        click_on "アカウントを削除する"
        expect(page).to have_content("アカウントを削除しました")
      end
    end
  end
end
