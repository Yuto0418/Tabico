require 'rails_helper'

RSpec.feature "Tweets_feature", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user: user) }
  let!(:comment) { FactoryBot.create(:comment, user: user, tweet: tweet) }

  scenario "コメントに成功する" do
    valid_login(user)
    expect(current_path).to eq root_path
    expect(page).to have_link "投稿一覧"

    click_on "投稿一覧"

    expect(current_path).to eq "/tweets/index"
    expect(page).to have_link "コメントする"

    click_on "コメントする"

    expect(current_path).to eq tweet_path(tweet)

    fill_in "コメントを入力", with: "MyText"

    click_on "投稿"

    expect(page).to have_content "コメントしました"
  end

  scenario "コメントを削除する" do
    valid_login(user)
    expect(current_path).to eq root_path
    expect(page).to have_link "投稿一覧"

    click_on "投稿一覧"

    expect(current_path).to eq "/tweets/index"
    expect(page).to have_link "コメントする"

    click_on "コメントする"

    expect(current_path).to eq tweet_path(tweet)

    expect(page).to have_link "コメントを削除する"

    click_on "コメントを削除する"

    expect(page).to have_content "コメントを削除しました"
  end
end
