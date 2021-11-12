require 'rails_helper'

RSpec.feature "Users_feature", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario "ユーザーの更新に成功する" do
    valid_login(user)
    expect(current_path).to eq root_path

    click_link "マイページ"

    expect(current_path).to eq user_path(user)

    click_link "プロフィール編集"

    expect(current_path).to eq edit_user_path(user)

    fill_in "名前", with: "NewName"
    fill_in "紹介文", with: "NewDescription"

    click_button "更新"

    expect(current_path).to eq user_path(user)
    expect(user.reload.name).to eq "NewName"
  end

  scenario "ユーザーの更新に失敗する" do
    valid_login(user)
    expect(current_path).to eq root_path

    click_link "マイページ"

    expect(current_path).to eq user_path(user)

    click_link "プロフィール編集"

    expect(current_path).to eq edit_user_path(user)

    fill_in "名前", with: ""
    fill_in "紹介文", with: ""

    click_button "更新"

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "情報の更新が失敗しました"
  end
end
