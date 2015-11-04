FactoryGirl.define do
  factory :bidder do
    association :auction
    after :build do |bidder|
      bidder.tickets << FactoryGirl.build(:ticket, auction: bidder.auction)
    end
  end
end
