RSpec.describe Bid do
  it { is_expected.to belong_to :auction_item }

  it { is_expected.to belong_to :bidder }

  it { is_expected.to have_attribute :amount }

  it { is_expected.to have_attribute :winner }

  it "has winner = false by default" do
    expect(subject).not_to be_winner
  end
end
