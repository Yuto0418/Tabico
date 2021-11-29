require 'rails_helper'

RSpec.feature "Tweets_feature", type: :feature do
  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user: user) }

  scenario "新規投稿に成功する" do
    valid_login(user)
    expect(current_path).to eq root_path
    expect(page).to have_link "投稿一覧"

    click_on "投稿一覧"

    expect(current_path).to eq "/tweets/index"
    expect(page).to have_link "投稿"

    click_on "投稿"

    expect(current_path).to eq new_tweet_path

    fill_in "投稿内容入力", with: "MyString"

    click_on "投稿"

    expect(page).to have_content "投稿しました"
  end

  scenario "投稿を削除する" do
    valid_login(user)
    expect(current_path).to eq root_path
    expect(page).to have_link "投稿一覧"

    click_on "投稿一覧"

    expect(current_path).to eq "/tweets/index"
    expect(page).to have_link "コメントする"

    click_on "コメントする"

    expect(current_path).to eq tweet_path(tweet)

    expect(page).to have_link "投稿を削除する"

    click_on "投稿を削除する"

    expect(page).to have_content "投稿を削除しました"
  end

  scenario "投稿一覧のフリーワード検索に成功する" do
    valid_login(user)
    expect(current_path).to eq root_path

    click_link "投稿一覧"

    expect(current_path).to eq "/tweets/index"

    fill_in "フリーワード検索", with: "MyString"

    click_button "検索"

    expect(current_path).to eq search_tweets_path
    expect(page).to have_content "MyString"
  end
end
