module LoginSupport
  def valid_login(user)
    visit root_path
    click_link "ログイン"
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  def valid_signup(user)
    visit root_path
    click_link "新規登録"
    fill_in "名前", with: user.name
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: user.password
    fill_in "パスワード(確認)", with: user.password_confirmation
    click_button "新規ユーザー登録"
  end
end
