RSpec.describe BidderTicket do
  it { is_expected.to belong_to :bidder }

  it { is_expected.to belong_to :ticket }

  it { is_expected.to validate_presence_of :bidder }

  it { is_expected.to validate_presence_of :ticket }
end
