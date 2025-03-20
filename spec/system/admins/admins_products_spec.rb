require 'rails_helper'

RSpec.describe 'Admins::Products', type: :system do
  let(:admin) { create(:admin) }

  describe '商品一覧ページ' do
    context 'ログインしている場合' do
      before do
        sign_in admin
      end

      it '商品一覧が表示されること' do
        create(:product, name: 'りんご')
        create(:product, name: 'みかん')

        visit admins_root_path

        click_link '商品一覧'

        expect(page).to have_content 'りんご'
        expect(page).to have_content 'みかん'
      end
    end

    context 'ログアウトしている場合' do
      it '商品の登録画面にアクセスできないこと' do
        visit new_admins_product_path

        expect(page).to have_current_path new_admin_session_path
      end
    end
  end

  describe '商品詳細ページ' do
    context 'ログインしている場合' do
      before do
        sign_in admin
      end

      it '商品詳細が表示されること' do
        create(:product, name: 'りんご', description: '青森県産', price_before_tax: 200)

        visit admins_root_path

        click_link '商品一覧'

        click_link 'りんご'

        expect(page).to have_content 'りんご'
        expect(page).to have_content '青森県産'
        expect(page).to have_content '200円'
      end
    end
  end

  describe '商品新規登録ページ' do
    context 'ログインしている場合' do
      before do
        sign_in admin
      end

      it '商品登録ができること' do
        visit admins_root_path

        click_link '商品登録'

        fill_in '商品名', with: 'みかん'

        click_button '登録する'

        expect(page).to have_content '商品を登録しました'

        expect(page).to have_current_path admins_products_path
      end
    end
  end

  describe '商品編集ページ' do
    context 'ログインしている場合' do
      before do
        sign_in admin
      end

      it '商品編集ができること' do
        product = create(:product, name: 'りんご')
        visit admins_product_path(product)

        click_link '編集'

        fill_in '商品名', with: 'みかん'

        click_button '更新する'

        expect(page).to have_content '商品を更新しました'
        expect(page).to have_content 'みかん'
        expect(page).to have_current_path admins_product_path(product)
      end
    end
  end

  describe '商品削除機能' do
    context 'ログインしている場合' do
      before do
        sign_in admin
      end

      it '商品削除ができること' do
        product = create(:product)
        visit admins_product_path(product)

        accept_alert('本当に削除しますか？') do
          click_button '削除'
        end

        expect(page).to have_content '商品を削除しました'
        expect(page).to have_current_path admins_products_path
      end
    end
  end
end
