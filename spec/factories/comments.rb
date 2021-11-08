FactoryBot.define do
  factory :comment do
    comment_text { "MyText" }
    user { nil }
    tweet { nil }
  end
end
