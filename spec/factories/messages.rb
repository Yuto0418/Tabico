FactoryBot.define do
  factory :message do
    user
    room
    message { "MyText" }
  end
end
