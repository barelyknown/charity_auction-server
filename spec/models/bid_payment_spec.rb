RSpec.describe BidPayment do
  it { is_expected.to belong_to :bid }

  it { is_expected.to belong_to :payment }

  it { is_expected.to have_attribute :amount }

  it { is_expected.to validate_presence_of :bid }

  it { is_expected.to validate_presence_of :payment }

  it { is_expected.to validate_presence_of :amount }

  it "validates that the amount is less than or equal to the unapplied amount of the payment" do
    payment = Payment.new
    expect(payment).to receive(:unapplied_amount).exactly(:twice).and_return(100)
    subject.payment = payment
    subject.amount = 101
    subject.valid?
    expect(subject.errors[:amount]).to include "must be less than or equal to the payment's unapplied amount"
    subject.amount = 100
    subject.valid?
    expect(subject.errors[:amount]).to be_empty
  end

  it "validates that the bid is a winner" do
    subject.bid = Bid.new(winner: false)
    subject.valid?
    expect(subject.errors[:bid]).to include "must be a winner"
    subject.bid.winner = true
    subject.valid?
    expect(subject.errors[:bid]).to be_empty
  end
end
