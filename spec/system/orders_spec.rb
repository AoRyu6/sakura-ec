require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  describe '注文機能' do
    context 'ログインしている場合' do
      let(:user) { create(:user) }
      let(:cart) { create(:cart, user: user) }

      before do
        sign_in user
        create(:cart_item, cart: cart, product: create(:product, :published))
      end

      it 'カートの商品が注文できること' do
        visit root_path

        click_link 'ショッピングカート'

        accept_alert('注文を確定してもよろしいですか?') do
          click_button '購入する'
        end

        expect(page).to have_content('注文を受け付けました。メール内容をご確認ください。')
        expect(page).to have_current_path root_path
      end
    end
  end
end
