require 'rails_helper'

RSpec.describe 'Carts', type: :system do
  context 'カートに商品が入っていない場合' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    it 'カートに商品が入っていませんと表示されること' do
      visit cart_path

      expect(page).to have_content 'カートに商品が入っていません'
    end
  end

  describe '金額計算機能' do
    let(:user) { create(:user) }
    let(:cart) { create(:cart, user: user) }
    let(:product) { create(:product, :published, price: 1000) }

    before do
      sign_in user
      create(:cart_item, cart: cart, product: product)
    end

    context 'カートに商品が入っている場合' do
      it '小計、送料、代引き決済手数料、合計が正しく表示されること' do
        visit cart_path

        # 小計
        expect(page).to have_content '1,080円'
        # 送料
        expect(page).to have_content '600円'
        # 代引き決済手数料
        expect(page).to have_content '300円'
        # 合計金額
        expect(page).to have_content '1,980円'
      end
    end
  end
end
