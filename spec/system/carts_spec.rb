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
end
