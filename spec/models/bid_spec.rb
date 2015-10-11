RSpec.describe Bid do
  it { is_expected.to belong_to :donation }

  it { is_expected.to belong_to :bidder }

  ["amount_dollars", "quantity", "placed_at"].each do |attribute|
    it { is_expected.to have_attribute attribute }
  end

  ["donation", "bidder", "amount_dollars", "quantity", "placed_at"].each do |required_attribute|
    it { is_expected.to validate_presence_of required_attribute }
  end

  it "validates that amount_dollars is greater than 0" do
    subject.amount_dollars = 0
    subject.valid?
    expect(subject.errors[:amount_dollars]).to include "must be greater than 0"
    subject.amount_dollars = 1
    subject.valid?
  end

  it "validates that the quantity is between 1 and the donation's quantity" do
    subject.donation = Donation.new(quantity: 2)
    subject.quantity = 0
    subject.valid?
    expect(subject.errors[:quantity]).to include "must be greater than or equal to 1 and less than or equal to 2"
  end
end
