require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  include ActiveJob::TestHelper

  scenario "ユーザーはサインアップに成功すること" do
    visit root_path
    click_link "新規登録"
    perform_enqueued_jobs do
      expect {
        fill_in "名前",              with: "Example"
        fill_in "Eメール",     with: "test@example.com"
        fill_in "パスワード",         with: "test123"
        fill_in "パスワード(確認)",  with: "test123"
        click_button "新規登録"
      }.to change(User, :count).by(1)

      expect(current_path).to eq root_path
    end
  end
end
