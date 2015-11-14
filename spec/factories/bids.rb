FactoryGirl.define do
  factory :bid do
    auction_item nil
    association :bidder
    winner false
    amount "9.99"
    after(:build) do |bid|
      unless bid.auction_item
        bid.auction_item = FactoryGirl.build(:auction_item, auction: bid.bidder.auction)
      end
    end
  end
end
