RSpec.describe Bidder do
  it { is_expected.to belong_to :auction }

  it { is_expected.to validate_presence_of :auction }

  it { is_expected.to have_many :bidder_tickets }

  it { is_expected.to have_many :bids }

  it { is_expected.to have_many(:tickets).through(:bidder_tickets) }

  it { is_expected.to have_attribute(:number) }

  it { is_expected.to validate_presence_of :number }

  it { is_expected.to have_many :payments }

  it "validates that the number is unique for the auction" do
    original = FactoryGirl.create(:bidder)
    duplicate = Bidder.new(auction: original.auction, number: original.number)
    duplicate.valid?
    expect(duplicate.errors[:number]).to include "has already been taken"
  end

  it "validates that tickets aren't empty" do
    subject.tickets = []
    subject.valid?
    expect(subject.errors[:tickets]).to include "must not be empty"
  end

  it "has a valid factory" do
    expect{FactoryGirl.create(:bidder)}.not_to raise_error
  end

  it "sets the number to the next integer for the auction if it isn't provided" do
    auction = FactoryGirl.create(:auction)
    subject = Bidder.new(auction: auction)
    subject.run_callbacks(:validation)
    expect(subject.number).to eq "1"
  end
end
