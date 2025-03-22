require 'rails_helper'

RSpec.describe 'CartItems', type: :system do
  describe 'カートに商品を追加する機能' do
    let(:user) { create(:user) }
    let(:product) { create(:product, name: 'りんご') }

    before do
      sign_in user
    end

    context 'ログインしている場合' do
      it '商品をカートに追加できること' do
        visit product_path(product)

        click_button 'カートに追加'

        expect(page).to have_content 'カートに商品を追加しました'

        click_link 'ショッピングカート'

        expect(page).to have_content 'りんご'
      end
    end
  end
end
