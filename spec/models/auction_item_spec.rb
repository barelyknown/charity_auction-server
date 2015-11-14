RSpec.describe AuctionItem do
  before do
    CharityAuctionServer::Application.load_tasks
    Rake::Task["seed:bid_types"].execute
  end

  [:auction, :donation, :bid_type].each do |required_belongs_to|
    it { is_expected.to belong_to required_belongs_to }
    it { is_expected.to validate_presence_of required_belongs_to }
  end

  it { is_expected.to belong_to :bid_group }

  it { is_expected.to have_attribute :minimum_bid_amount }

  it { is_expected.to have_attribute :sequence }

  it { is_expected.to have_attribute :number }

  it { is_expected.to have_many :bids }

  it "validates that the number is unique for the auction" do
    original = FactoryGirl.create(:auction_item)
    duplicate = AuctionItem.new(auction: original.auction, number: original.number)
    duplicate.valid?
    expect(duplicate.errors[:number]).to include "has already been taken"
  end

  it "can rank the auction items by sequence" do
    auction = FactoryGirl.create(:auction)
    auction_items = [
      auction.auction_items.create!(sequence_position: :first, donation: FactoryGirl.create(:donation, auction: auction), bid_type: BidType.last),
      auction.auction_items.create!(sequence_position: :first, donation: FactoryGirl.create(:donation, auction: auction), bid_type: BidType.last)
    ]
    expect(auction.auction_items.map(&:id)).to eq auction_items.reverse.map(&:id)
  end

  context "when the bid type is named fixed-price" do
    before do
      subject.bid_type = BidType.new(name: "fixed-price")
    end
    it "validates that the minimum_bid_amount is greater than 0" do
      subject.minimum_bid_amount = 0
      subject.valid?
      expect(subject.errors[:minimum_bid_amount]).to include "must be greater than 0"
    end
  end

  context "when the bid type is not fixed price" do
    before do
      subject.bid_type = BidType.new(name: "live")
    end
    it "validates that the minimum_bid_amount is nil or greater than 0" do
      subject.minimum_bid_amount = nil
      subject.valid?
      expect(subject.errors[:minimum_bid_amount]).to be_empty
      subject.minimum_bid_amount = 0
      subject.valid?
      expect(subject.errors[:minimum_bid_amount]).to include "must be greater than 0"
      subject.minimum_bid_amount = 1
      subject.valid?
      expect(subject.errors[:minimum_bid_amount]).to be_empty
    end
  end
end
