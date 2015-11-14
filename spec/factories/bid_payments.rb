FactoryGirl.define do
  factory :bid_payment do
    association :bid, strategy: :build
    association :payment, strategy: :build
    amount "9.99"
  end
end
