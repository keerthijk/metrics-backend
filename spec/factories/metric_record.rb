FactoryBot.define do
  factory :metric_record do
    value { Faker::Number.between(from: 1, to: 100) }
    timestamp { Faker::Time.backward(days: 30, period: :all) }
    association :metric
  end
end
