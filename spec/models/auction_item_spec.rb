RSpec.describe AuctionItem do
  [:auction, :donation, :bid_type].each do |required_belongs_to|
    it { is_expected.to belong_to required_belongs_to }
    it { is_expected.to validate_presence_of required_belongs_to }
  end

  it { is_expected.to belong_to :bid_group }
end
