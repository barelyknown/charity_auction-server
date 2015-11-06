RSpec.describe Ticket do
  it { is_expected.to belong_to :user }

  it { is_expected.to belong_to :auction }

  it { is_expected.to have_many :bidder_tickets }

  it { is_expected.to have_many(:bidders).through(:bidder_tickets) }

  it { is_expected.to have_attribute :price }

  it { is_expected.to have_attribute :number }

  it "defaults to create_bidder_automatically" do
    expect(subject.create_bidder_automatically).to eq true
  end

  context "when create_bidder_automatically = false" do
    before do
      subject.create_bidder_automatically = false
    end
    it "does not create a bidder automatically" do
      expect{FactoryGirl.create(:ticket, create_bidder_automatically: false)}.to change{Bidder.count}.by(0)
    end
  end

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

  it "creates a bidder for the ticket after commit on create" do
    subject = FactoryGirl.create(:ticket)
    expect(subject.bidders.count).to eq 1
  end

  it "can be destroyed even if it has bidder tickets" do
    subject = FactoryGirl.create(:ticket)
    bidder = subject.bidders.first
    expect{subject.destroy}.not_to raise_error
    expect(Bidder.find_by(id: bidder.id)).to be_nil
  end
end
