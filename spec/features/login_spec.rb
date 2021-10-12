require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario "ログインに成功しログアウトすること" do
    valid_login(user)
    expect(current_path).to eq root_path
    expect(page).to_not have_content "ログイン"

    click_link "ログアウト"

    expect(current_path).to eq root_path
    expect(page).to have_content "ログイン"
  end

  scenario "無効な情報ではログインに失敗すること" do
    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: ""
    fill_in "パスワード", with: ""
    click_button "ログイン"

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content "ログイン"
  end
end
