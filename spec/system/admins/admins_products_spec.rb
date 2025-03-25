require 'rails_helper'

RSpec.describe 'Admins::Products', type: :system do
  let(:admin) { create(:admin) }

  describe '商品一覧ページ' do
    context 'ログインしている場合' do
      before do
        sign_in admin
      end

      it '商品名、価格(税抜き)、価格(税込), ステータス、が表示されること' do
        create(:product, :published, name: 'りんご', price: 100)

        visit admins_root_path

        expect(page).to have_content 'りんご'
        expect(page).to have_content '100円'
        expect(page).to have_content '108円'
        expect(page).to have_content '公開中'
      end

      it '商品の価格が設定されておらず、非公開の場合、未設定と非公開が表示されること' do
        create(:product, price: nil, published: false)

        visit admins_root_path

        expect(page).to have_content '未設定'
        expect(page).to have_content '非公開'
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
        create(:product, name: 'りんご', description: '青森県産', price: 200)

        visit admins_root_path

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

        click_link '商品新規登録'

        fill_in '商品名', with: 'みかん'

        click_button '登録する'

        expect(page).to have_content '商品を登録しました'

        expect(page).to have_current_path admins_products_path
      end

      it '商品名が入力されていない場合、エラーメッセージが表示されること' do
        visit new_admins_product_path

        click_button '登録する'

        expect(page).to have_content '商品名を入力してください'
      end

      it '25MB以上の画像がアップロードされた場合、バリデーションエラーが出ること' do
        visit new_admins_product_path

        fill_in '商品名', with: 'りんご'
        attach_file '画像', file_fixture('30MB.png')
        click_button '登録する'

        expect(page).to have_content '商品画像は25MB以下にしてください'
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
