RSpec.describe Payment do
  it { is_expected.to belong_to :bidder }
  it { is_expected.to have_attribute :amount }
  it { is_expected.to belong_to :auction }

  it { is_expected.to have_many :bid_payments }

  it { is_expected.to validate_presence_of :auction }

  it "validates that the amount is greater than 0" do
    subject.amount = 0
    subject.valid?
    expect(subject.errors[:amount]).to include "must be greater than 0"
  end

  it "has the correct payment methods" do
    expect(described_class.payment_methods).to eq ({
      "cash" => 0,
      "check" => 1,
      "credit_card" => 2
    })
  end

  it "has applied and unapplied amounts" do
    auction = FactoryGirl.create(:auction)
    payment = FactoryGirl.create(:payment, amount: 100, auction: auction)
    expect(payment.applied_amount).to eq 0
    auction_item = FactoryGirl.create(:auction_item, auction: auction)
    bid = FactoryGirl.create(:bid, auction_item: auction_item, winner: true)
    payment.bid_payments.create!(bid: bid, amount: 40)
    expect(payment.applied_amount).to eq 40
    expect(payment.unapplied_amount).to eq 60
  end
end
