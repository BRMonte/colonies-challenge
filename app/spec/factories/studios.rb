FactoryBot.define do
  factory :studio do
    sequence(:name) { |n| "Studio #{n}" }
    description { "MyText" }
  end
end
