FactoryBot.define do
  factory :stay do
    start_date { Date.today }
    end_date { Date.tomorrow }
    association :studio

    trait :without_end_date do
      end_date { nil }
    end
  end
end

