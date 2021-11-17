require 'rails_helper'

RSpec.feature "Users_feature", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user: user) }
  let(:other_user) { FactoryBot.create(:user) }

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

  scenario "ユーザーのフォローに成功する" do
    valid_login(other_user)
    expect(current_path).to eq root_path

    click_link "投稿一覧"

    expect(current_path).to eq "/tweets/index"

    click_link "テスト用ユーザー"

    expect(current_path).to eq user_path(user)

    click_button "フォロー"

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "フォローしました"
  end

  scenario "ユーザーのフォロー解除に成功する" do
    valid_login(other_user)
    expect(current_path).to eq root_path

    click_link "投稿一覧"

    expect(current_path).to eq "/tweets/index"

    click_link "テスト用ユーザー"

    expect(current_path).to eq user_path(user)

    click_button "フォロー"

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "フォローしました"

    click_button "フォロー中"

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "フォローを解除しました"
  end

  scenario "フォロー中のユーザー検索に成功する" do
    valid_login(other_user)
    expect(current_path).to eq root_path

    click_link "投稿一覧"

    expect(current_path).to eq "/tweets/index"

    click_link "テスト用ユーザー"

    expect(current_path).to eq user_path(user)

    click_button "フォロー"

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "フォローしました"

    click_link "マイページ"

    expect(current_path).to eq user_path(other_user)

    click_link "フォロー"

    expect(current_path).to eq followings_user_path(other_user)

    fill_in "ユーザー検索", with: "テスト用ユーザー"

    click_button "検索"

    expect(current_path).to eq search_users_path
    expect(page).to have_content "テスト用ユーザー"
  end
end
