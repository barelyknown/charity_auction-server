FactoryGirl.define do
  factory :auction_item do
    association :auction, strategy: :build
    association :donation, strategy: :build
    association :bid_type, strategy: :build
    association :bid_group, strategy: :build
  end
end
