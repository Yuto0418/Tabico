require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create_list(:tweet, 5, user: user) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "投稿一覧画面が正常なレスポンスを返すこと" do
      get "/tweets/index"
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    it "投稿一覧画面に投稿が表示されること" do
      get "/tweets/index"
      expect(response.body).to include tweet[0].body
    end

    it "投稿一覧画面に投稿が5件表示されること" do
      expect(tweet.count).to eq 5
    end
  end

  describe "GET #new" do
    it "投稿ページが正常なレスポンスを返すこと" do
      get "/tweets/new"
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #show" do
    it "投稿詳細ページが正常なレスポンスを返すこと" do
      get tweet_path(tweet)
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    it "投稿詳細ページのレスポンスに名前と投稿内容が含まれること" do
      get tweet_path(tweet)
      expect(response.body).to include user.name
      expect(response.body).to include tweet[0].body
    end
  end

  describe "GET #search" do
    it "検索結果ページが正常なレスポンスを返すこと" do
      get search_tweets_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
end
