require 'rails_helper'

RSpec.describe 'Products', type: :system do
  describe '商品一覧機能' do
    context '商品が公開されている場合' do
      it '商品が一覧で表示されていること' do
        create(:product, :published, name: 'りんご')
        create(:product, :published, name: 'みかん')

        visit root_path

        expect(page).to have_content('りんご')
        expect(page).to have_content('みかん')
      end
    end

    context '商品が非公開の場合' do
      it '非公開の商品が一覧に表示されないこと' do
        create(:product, name: 'バナナ', published: false)
        create(:product, :published, name: 'りんご')
        create(:product, :published, name: 'みかん')

        visit root_path

        expect(page).to have_content('りんご')
        expect(page).to have_content('みかん')
        expect(page).not_to have_content('バナナ')
      end
    end
  end

  describe '商品詳細機能' do
    context '商品が公開されている場合' do
      it '商品の詳細が表示されていること' do
        product = create(:product, :published, name: 'りんご', description: '新鮮なりんごです。')

        visit product_path(product)

        expect(page).to have_content('りんご')
        expect(page).to have_content('新鮮なりんごです。')
      end
    end
  end
end
