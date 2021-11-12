require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /index" do
    it "トップページが正常なレスポンスを返すこと" do
      get "/users"
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #new" do
    it "新規登録ページが正常なレスポンスを返すこと" do
      get new_user_registration_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    it "ログインページが正常なレスポンスを返すこと" do
      get new_user_session_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end

    it "テスト用ユーザーとしてログインし、正常なレスポンスを返すこと" do
      sign_in_as user
      get root_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #edit" do
    it "アカウント設定ページが正常なレスポンスを返すこと" do
      sign_in_as user
      get edit_user_path(user)
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "#update" do
    it "ユーザーを更新できること" do
      user_params = FactoryBot.attributes_for(:user, name: "NewName", description: "NewDescription")
      sign_in_as user
      patch user_path(user), params: { id: user.id, user: user_params }
      expect(user.reload.name).to eq "NewName"
      expect(user.reload.description).to eq "NewDescription"
    end
  end
end
