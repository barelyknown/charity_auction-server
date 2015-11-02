FactoryGirl.define do
  factory :donation do
    title "Ski Resort Weekend"
    description "You get my place for three days."
    quantity 1
    association :auction, strategy: :build
    association :bid_type, strategy: :build
    redemption_window_starts_at "2015-10-10 22:43:45"
    redemption_window_ends_at "2015-10-10 23:43:45"
    estimated_value_amount 10000
    minimum_bid_amount 3000
    display_description "Pictures of the group in the hot tub."
    fulfillment_type "certificate"
  end
end
