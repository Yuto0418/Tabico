FactoryBot.define do
  factory :relationship do
    follow_id { FactoryBot.create(:user).id }
  end
end
