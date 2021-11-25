require 'rails_helper'

RSpec.feature "rooms_feature", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user: user) }
  let!(:other_user) { FactoryBot.create(:user) }
  let(:room) { FactoryBot.create(:room) }

  scenario "DMを送ることに成功する" do
    valid_login(other_user)
    expect(current_path).to eq root_path

    click_link "投稿一覧"

    expect(current_path).to eq "/tweets/index"

    click_link "テスト用ユーザー"

    expect(current_path).to eq user_path(user)

    click_button "フォロー"

    expect(current_path).to eq user_path(user)
    expect(page).to have_content "フォローしました"

    click_link "ログアウト"

    valid_login(user)
    expect(current_path).to eq root_path

    click_link "マイページ"

    click_link "フォロワー"

    expect(page).to have_content other_user.name

    click_link other_user.name

    expect(current_path).to eq user_path(other_user)

    click_button "フォロー"

    expect(page).to have_content "フォローしました"

    click_button "DMを送る"

    fill_in "message[message]", with: "MyText"

    click_on "送る"

    expect(page).to have_content "MyText"
  end
end
