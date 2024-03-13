FactoryBot.define do
  factory :stay do
    start_date { Date.today }
    end_date { Date.tomorrow }
    association :studio
  end
end

