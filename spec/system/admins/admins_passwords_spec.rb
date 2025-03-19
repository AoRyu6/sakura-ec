require 'rails_helper'

RSpec.describe 'Admins::Passwords', type: :system do
  let!(:admin) { create(:admin) }

  it 'パスワードを再設定できること' do
    visit new_admin_password_path

    expect(page).to have_content 'パスワードの再設定'

    fill_in 'メールアドレス', with: 'admin@example.com'
    click_button '送信'

    expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'
    expect(ActionMailer::Base.deliveries.count).to eq(1)

    email = ActionMailer::Base.deliveries.last

    expect(email.subject).to include('パスワードの再設定について')
    expect(email.to).to include(admin.email)

    password_reset_url = URI.extract(email.body.encoded)[0]
    visit password_reset_url

    expect(page).to have_content('パスワード再設定')

    fill_in '新しいパスワード', with: 'changepassword', match: :first
    fill_in '新しいパスワードの再入力', with: 'changepassword'
    click_button '送信'
    expect(page).to have_content 'パスワードが正しく変更されました。'
    expect(page).to have_current_path admins_root_path
  end
end
