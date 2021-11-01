require 'rails_helper'

RSpec.feature "Users_feature", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario "ユーザーの更新に成功する" do
    valid_login(user)
    expect(current_path).to eq root_path

    click_link "アカウント設定"

    fill_in "名前", with: "NewName"

    click_button "更新"

    expect(current_path).to eq user_path(user)
    expect(user.reload.name).to eq "NewName"
  end

  scenario "ユーザーの更新に失敗する" do
    valid_login(user)
    expect(current_path).to eq root_path

    click_link "アカウント設定"

    fill_in "名前", with: ""

    click_button "更新"

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "情報の更新が失敗しました"
  end
end
