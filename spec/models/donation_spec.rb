RSpec.describe Donation do
  [
    "title",
    "description",
    "quantity",
    "redemption_window_starts_at",
    "redemption_window_ends_at",
    "estimated_value_amount",
    "minimum_bid_amount",
    "display_description",
    "admin_follow_up_needed",
    "fulfillment_type"
  ].each do |attribute|
    it { is_expected.to have_attribute attribute }
  end

  it { is_expected.to belong_to :bid_type }

  it { is_expected.to belong_to :donation_category }

  ["auction", "donor"].each do |required_relationship|
    it { is_expected.to belong_to required_relationship }

    it { is_expected.to validate_presence_of required_relationship }
  end

  it "validates that quantity is either nil or greater than 0" do
    subject.quantity = nil
    subject.valid?
    expect(subject.errors[:quantity]).to be_empty
    subject.quantity = 0
    subject.valid?
    expect(subject.errors[:quantity]).to include "must be greater than 0"
    subject.quantity = 1
    subject.valid?
    expect(subject.errors[:quantity]).to be_empty
  end

  it "validates that redemption_window_ends_at is after redemption_window_starts_at" do
    subject.redemption_window_starts_at = DateTime.new(2015,10,10,11,00)
    subject.redemption_window_ends_at = subject.redemption_window_starts_at
    subject.valid?
    expect(subject.errors[:redemption_window_ends_at]).to include "must be greater than redemption_window_starts_at"
    subject.redemption_window_ends_at = subject.redemption_window_starts_at.advance(seconds: 1)
    subject.valid?
    expect(subject.errors[:redemption_window_ends_at]).to be_empty
  end

  it "validates that the estimated_value_amount is either nil or greater than or equal to 0" do
    subject.estimated_value_amount = nil
    subject.valid?
    expect(subject.errors[:estimated_value_amount]).to be_empty
    subject.estimated_value_amount = -1
    subject.valid?
    expect(subject.errors[:estimated_value_amount]).to include "must be greater than or equal to 0"
    subject.estimated_value_amount = 0
    subject.valid?
    expect(subject.errors[:estimated_value_amount]).to be_empty
  end

  it "validates that the minimum_bid_amount is either nil or greater than 0" do
    subject.minimum_bid_amount = nil
    subject.valid?
    expect(subject.errors[:minimum_bid_amount]).to be_empty
    subject.minimum_bid_amount = 0
    subject.valid?
    expect(subject.errors[:minimum_bid_amount]).to include "must be greater than 0"
    subject.minimum_bid_amount = 1
    subject.valid?
    expect(subject.errors[:minimum_bid_dollars]).to be_empty
  end

  it "defaults the admin_follow_up_needed to false" do
    expect(subject.admin_follow_up_needed).to eq false
  end

  it "has the fulfillment_type enum definition" do
    expect(described_class.fulfillment_types).to eq({
      "item" => 0,
      "certificate" => 1
    })
  end

  it "has a nil fulfillment_type after initialization" do
    expect(subject.fulfillment_type).to be_nil
  end
end
