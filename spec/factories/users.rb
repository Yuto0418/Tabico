FactoryBot.define do
  factory :user do
    name { 'テスト用ユーザー' }
    email { 'test@gmail.com' }
    password = 'test1234'
    password { password }
    password_confirmation { password }
  end
end
