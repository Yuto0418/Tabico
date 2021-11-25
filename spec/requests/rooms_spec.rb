require 'rails_helper'

RSpec.describe "Rooms", type: :request do

    let!(:user) { FactoryBot.create(:user) }
    let!(:other_user) { FactoryBot.create(:user) }
    let!(:room) { FactoryBot.create(:room) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "DM一覧ページが正常なレスポンスを返すこと" do
      get rooms_path
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
end
