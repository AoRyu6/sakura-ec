require 'rails_helper'

RSpec.describe 'Users::Sessions', type: :system do
  let!(:user) { create(:user, email: 'user@example.com', password: 'password12345') }

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it 'ログアウトができること' do
      visit root_path

      accept_alert('本当にログアウトしますか？') do
        click_button 'ログアウト'
      end

      expect(page).to have_content 'ログアウトしました'
      expect(page).to have_current_path root_path
    end
  end

  context 'ログインしていない場合' do
    it 'ログインができること' do
      visit root_path

      click_link 'ログイン'

      fill_in 'メールアドレス', with: 'user@example.com'
      fill_in 'パスワード', with: 'password12345'
      click_button 'ログイン'

      expect(page).to have_content 'ログインしました'
      expect(page).to have_current_path root_path
    end
  end

  context 'メールアドレスが間違っている場合' do
    it 'ログインに失敗すること' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'invalid@example.com'
      fill_in 'パスワード', with: 'password12345'
      click_button 'ログイン'

      expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      expect(page).to have_current_path new_user_session_path
    end
  end

  context 'パスワードが間違っている場合' do
    it 'ログインに失敗すること' do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'user@example.com'
      fill_in 'パスワード', with: 'invalid_password'
      click_button 'ログイン'

      expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
      expect(page).to have_current_path new_user_session_path
    end
  end
end
