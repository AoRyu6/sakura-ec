require 'rails_helper'

RSpec.describe 'ShippingAddresses', type: :system do
  describe '配送先一覧機能' do
    context 'ログインしている場合' do
      let(:user) { create(:user) }

      before do
        sign_in user
        create(:shipping_address, recipient_name: '山田', city: '千代田', user: user)
      end

      it 'ユーザーは配送先住所一覧を見ることができること' do
        visit shipping_addresses_path

        expect(page).to have_content('山田')
        expect(page).to have_content('千代田')
      end
    end
  end

  describe '配送先住所の登録' do
    context 'ログインしている場合' do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it 'ユーザーは新しい配送先住所を登録できること' do
        visit diaries_path

        click_link '配送先情報'
        click_link '新しいお届け先住所を登録'

        fill_in '宛名', with: 'ユーザー'
        fill_in '郵便番号', with: '1234567'
        select '東京都', from: '都道府県'
        fill_in '市区町村', with: '千代田区'
        click_button '登録'

        expect(page).to have_content('配送先住所を登録しました')
        expect(page).to have_current_path(shipping_addresses_path)
      end

      it '郵便番号がが未入力の場合、エラーメッセージが表示されること' do
        visit new_shipping_address_path

        select '東京都', from: '都道府県'
        fill_in '市区町村', with: '千代田区'
        fill_in '市区町村', with: '千代田区'
        click_button '登録'

        expect(page).to have_content('郵便番号を入力してください')
      end
    end
  end

  describe '配送先更新機能' do
    context 'ログインしている場合' do
      let(:user) { create(:user) }

      before do
        sign_in user
        create(:shipping_address, user: user)
      end

      it 'ユーザーは配送先住所を更新できること' do
        visit shipping_addresses_path
        click_link '配送先を編集する'

        fill_in '市区町村', with: '千代田区'
        click_button '更新'

        expect(page).to have_content('配送先住所を更新しました')
        expect(page).to have_current_path(shipping_addresses_path)
        expect(page).to have_content('千代田区')
      end
    end
  end

  describe '配送先削除機能' do
    context 'ログインしている場合' do
      let(:user) { create(:user) }

      before do
        sign_in user
        create(:shipping_address, user: user)
      end

      it 'ユーザーは配送先住所を削除できること' do
        visit shipping_addresses_path

        accept_alert do
          click_button '配送先を削除する'
        end

        expect(page).to have_content('配送先住所を削除しました')
        expect(page).to have_current_path(shipping_addresses_path)
      end
    end
  end
end
