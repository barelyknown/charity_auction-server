RSpec.describe Bid do
  it { is_expected.to belong_to :auction_item }

  it { is_expected.to belong_to :bidder }

  it { is_expected.to have_attribute :amount }

  it { is_expected.to have_attribute :winner }

  it { is_expected.to have_many :bid_payments }

  it "has winner = false by default" do
    expect(subject).not_to be_winner
  end

  it "has a balance" do
    subject = FactoryGirl.create(:bid, amount: 100, winner: true)
    expect(subject.balance).to eq 100
    payment = FactoryGirl.create(:payment, amount: 1000, auction: subject.auction_item.auction)
    FactoryGirl.create(:bid_payment, bid: subject, payment: payment, amount: 40)
    expect(subject.balance).to eq 60
  end
end
