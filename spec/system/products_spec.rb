require 'rails_helper'

RSpec.describe 'Products', type: :system do
  describe '商品一覧機能' do
    before do
      create(:product, name: 'りんご')
      create(:product, name: 'みかん')
    end

    it '商品が一覧で表示されていること' do
      visit root_path

      expect(page).to have_content('りんご')
      expect(page).to have_content('みかん')
    end
  end

  describe '商品詳細機能' do
    it '商品の詳細が表示されていること' do
      product = create(:product, name: 'りんご', description: '新鮮なりんごです。')

      visit product_path(product)

      expect(page).to have_content('りんご')
      expect(page).to have_content('新鮮なりんごです。')
    end
  end
end
