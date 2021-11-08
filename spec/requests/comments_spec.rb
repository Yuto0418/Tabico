require 'rails_helper'

RSpec.describe "Comments", type: :request do

  let!(:user) { FactoryBot.create(:user) }
  let!(:tweet) { FactoryBot.create(:tweet, user: user) }
  let!(:comment) { FactoryBot.create(:comment, user: user, tweet: tweet) }

  before do
    sign_in user
  end

  describe "GET #show" do
    it "投稿詳細ページのレスポンスにコメントを入力と新規コメントが含まれること" do
      get tweet_path(tweet)
      expect(response.body).to include "コメントを入力"
      expect(response.body).to include comment.comment_text
    end
  end
end
