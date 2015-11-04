FactoryGirl.define do
  factory :bidder_ticket do
    association :bidder, strategy: :build
    association :ticket, strategy: :build
  end
end
