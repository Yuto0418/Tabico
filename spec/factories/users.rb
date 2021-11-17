FactoryBot.define do
  factory :user,class: User do
    name { 'テスト用ユーザー' }
    email { 'test@gmail.com' }
    password = 'test1234'
    password { password }
    password_confirmation { password }
    description { 'テスト用' }
  end

  factory :other_user,class: User do
    name { 'サンプルユーザー' }
    email { 'sample@gmail.com' }
    password = 'sample1234'
    password { password }
    password_confirmation { password }
    description { 'サンプル用' }
  end
end
