FactoryGirl.define do
  factory :bid_type do
    sequence(:name) { |n| "Bid Type #{n}" }
  end
end
