FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "テスト用ユーザー#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password = 'test1234'
    password { password }
    password_confirmation { password }
    description { 'テスト用' }
  end
end
