FactoryGirl.define do
  factory :bidder do
    association :auction
    sequence(:number) { |n| n.to_s }
    after :build do |bidder|
      bidder.tickets << FactoryGirl.build(:ticket, auction: bidder.auction)
    end
  end
end
