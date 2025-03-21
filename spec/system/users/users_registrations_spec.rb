require 'rails_helper'

RSpec.describe 'Users::Registrations', type: :system do
  it 'ユーザー登録とログインができること' do
    visit root_path

    click_link '新規登録'

    fill_in '名前', with: '山田 太郎'
    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password12345', match: :first
    fill_in 'パスワード（確認用）', with: 'password12345'

    click_button '登録する'

    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
    expect(ActionMailer::Base.deliveries.count).to eq(1)

    email = ActionMailer::Base.deliveries.last
    expect(email.subject).to include('メールアドレス確認メール')

    confirmation_url = URI.extract(email.body.encoded).find { |url| url.include?('/confirmation') }

    visit confirmation_url

    expect(page).to have_content 'メールアドレスが確認できました。'
    expect(page).to have_current_path(new_user_session_path)

    fill_in 'メールアドレス', with: 'test@example.com'
    fill_in 'パスワード', with: 'password12345'

    click_button 'ログイン'

    expect(page).to have_content 'ログインしました'
    expect(page).to have_current_path root_path
  end

  context 'ログインしている場合' do
    let(:user) { create(:user, name: '山田 太郎', password: 'password12345') }

    before do
      sign_in user
    end

    it '名前を変更できること' do
      visit root_path

      click_link '日記を見る'
      click_link 'プロフィールを編集する'

      fill_in '名前', with: '山田 花子'
      fill_in '現在のパスワード', with: 'password12345'
      click_button '更新'

      visit root_path

      visit diaries_path
      expect(page).to have_content '山田 花子'
    end
  end
end
