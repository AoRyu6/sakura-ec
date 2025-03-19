require 'rails_helper'

RSpec.describe 'Admins::Sessions', type: :system do
  let!(:admin) { create(:admin) }

  context 'ログインしているとき' do
    before do
      sign_in admin
    end

    it 'ログアウトができること' do
      visit admins_root_path

      expect(page).to have_current_path admins_root_path

      click_on 'admin@example.com'
      accept_alert('本当にログアウトしますか?') do
        click_button 'ログアウト'
      end

      expect(page).to have_content 'ログアウトしました。'
      expect(page).to have_current_path root_path
      expect(page).not_to have_button 'admin@example.com'
    end
  end

  context 'ログアウトしているとき' do
    it 'ログインできること' do
      visit admins_root_path

      expect(page).not_to have_current_path admins_root_path
      expect(page).to have_current_path new_admin_session_path

      fill_in 'メールアドレス', with: 'admin@example.com'
      fill_in 'パスワード', with: 'password12345'
      click_button 'ログイン'

      expect(page).to have_current_path admins_root_path
      expect(page).to have_button 'admin@example.com'
    end

    it '管理者ページにアクセスできないこと' do
      visit admins_root_path
      expect(page).to have_current_path new_admin_session_path
    end
  end
end
