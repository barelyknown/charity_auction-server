RSpec.describe Ticket do
  it { is_expected.to belong_to :user }

  it { is_expected.to belong_to :auction }

  it { is_expected.to have_attribute :price }

  it { is_expected.to have_attribute :number }

  it "validates that the price is greater than or equal to 0" do
    subject.price = -1
    subject.valid?
    expect(subject.errors[:price]).to include "must be greater than or equal to 0"
  end

  [:user, :auction, :price, :number].each do |required_attribute|
    it { is_expected.to validate_presence_of required_attribute }
  end

  it "validates that the number is unique scoped to the auction" do
    existing = FactoryGirl.create(:ticket)
    duplicate = Ticket.new(auction: existing.auction, number: existing.number)
    duplicate.valid?
    expect(duplicate.errors[:number]).to include "has already been taken"
  end

  it "sets the number to the next integer for the auction if it isn't provided" do
    auction = FactoryGirl.create(:auction)
    subject = Ticket.new(auction: auction)
    subject.run_callbacks(:validation)
    expect(subject.number).to eq "1"
  end
end
