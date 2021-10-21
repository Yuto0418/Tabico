require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  let!(:user) { FactoryBot.build(:user) }

  scenario "ユーザーは新規登録に成功すること" do
    visit root_path
    click_link "新規登録"
    visit new_user_registration_path
    expect do
      valid_signup(user)
    end.to change(User, :count).by(1)

    expect(current_path).to eq root_path
  end
end
